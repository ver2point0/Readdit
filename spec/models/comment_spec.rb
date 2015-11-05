require 'rails_helper'
include RandomData

RSpec.describe Comment, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user) { User.create!(name: "Readdit User", email: "user@readdit.io", password: "helloworld") }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:comment) { Comment.create!(body: "Comment body", post: post, user: user) }

  it { should belong_to(:post) }
  it { should belong_to(:user) }
  
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "should respond to body" do
      expect(comment).to respond_to(:body)
    end
  end
  
  describe "after_create" do
  
    before do
      @another_comment = Comment.new(body: "Comment body", post: post, user: user)
    end
    
    it "sends an emails to users who have favorited the post" do
      favorite = user.favorites.create(post: post)
      expect(FavoriteMailer).to receive(:new_comment).with(user, post, @another_comment).and_return(double(deliver_now: true))
      
      @another_comment.save
    end
    
    it "does not send emails to users who haven't favorited the post" do
      expect(FavoriteMailer).not_to receive(:new_comment)
      @another_comment.save 
    end
  end
  
  
end
