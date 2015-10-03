require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }
  let(:comment) { Comment.create!(body: "Comment body", post: post) }
  
  describe "attributes" do
    
    it "should respond to body" do
      expect(comment).to respond_to(:body)
    end
  end
  
end
