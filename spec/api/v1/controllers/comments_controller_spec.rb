require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
   
   let(:my_post) { create(:post) }
   let(:my_comment) { create(:comment, post: my_post, user: my_user) }
   let(:my_user) { create(:user) }
   
   context "unathenticated user" do
     
     it "GET index returns http success" do
       get :index
       expect(response).to have_http_status(:success)
     end
     
     it "GET show returns http success" do
       get :show, id: my_comment.id
       expect(response).to have_http_status(:success)
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
       get :show, id: my_comment.id
       expect(response).to have_http_status(:success)
     end
   end
   
end