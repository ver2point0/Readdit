require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  
  let(:my_topic) { create(:topic) }
  let(:my_user) { create(:user) }
  let(:my_post) { create(:post, topic: my_topic, user: my_user) }
  
  context "unathenticated user" do
    
    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it "GET show returns http success" do
      get :show, id: my_post.id
      expect(response).to have_http_status(:success)
    end
    
    it "PUT update returns http unathenticated" do
      put :update, id: my_post.id, post: {title: "Post Title", body: "This is the post body."}
      expect(response).to have_http_status(401)
    end
    
    it "POST create returns http unathenticated" do
      post :create, topic_id: my_topic.id, post: {title: "Post Title", body: "This is the body of the post."}
      expect(response).to have_http_status(401)
    end
    
    it "DELETE destroy returns http unathenticated" do
      delete :destroy, id: my_post.id
      expect(response).to have_http_status(401)
    end
  end
  
  context "unauthorized user" do
    
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end
   
   it "GET index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it "GET show returns http success" do
      get :show, id: my_post.id
      expect(response).to have_http_status(:success)
    end
    
    it "PUT update returns http forbidden" do
      put :update, id: my_post.id, post: {title: "Post Title", body: "This is the post body."}
      expect(response).to have_http_status(403)
    end
    
    it "POST create returns http forbidden" do
      post :create, topic_id: my_topic.id, post: {title: "Post Title", body: "This is the body of the post."}
      expect(response).to have_http_status(403)
    end
    
    it "DELETE destroy returns http forbidden" do
      delete :destroy, id: my_post.id
      expect(response).to have_http_status(403)
    end
  end
  
  context "authenticated and authorized user" do
    
    before do
      my_user.admin!
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
      @new_post = build(:post, topic: my_topic)
    end
    
    describe "PUT update" do
      
      before {put :update, id: my_post.id, post: {title: @new_post.title, body: @new_post.body} }
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      
      it "returns json context type" do
        expect(response.content_type).to eq('application/json')      
      end
      
      it "updates a post with the correct attributes" do
        updated_post = Post.find(my_post.id)
        expect(updated_post.to_json).to eq(response.body)
      end
    end
    
    describe "POST create" do
      
      before {post :create, topic_id: my_topic.id, user_id: my_user, post: {title: @new_post.title, body: @new_post.body} }
      
      it "returns http success" do
        expect(response).to have_http_status(:success)      
      end
      
      it "returns json content type" do
        expect(response.content_type).to eq('application/json')      
      end
      
      it "creates a post with the correct attributes" do
        hashed_json = JSON.parse(response.body)
        expect(@new_post.title).to eq(hashed_json["title"])
        expect(@new_post.body).to eq(hashed_json["body"])
      end
    end
    
    describe "DELETE destroy" do
      
      before { delete :destroy, id: my_post.id }
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      
      it "returns json content type" do
        expect(response.content_type).to eq('application/json')      
      end
      
      it "returns the correct success message" do
        expect(response.body).to eq({"message" => "Post destroyed", "status" => 200}.to_json) 
      end
      
      it "deletes my_post" do
        expect{ Post.find(my_post.id) }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
  
end