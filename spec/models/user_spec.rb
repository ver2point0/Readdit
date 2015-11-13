require 'rails_helper'
include RandomData

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  
  # Shoulda test for post, comments, votes, favorites association
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:votes) }
  it { should have_many(:favorites) }

  # Shoulda tests for name
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(1) }
  
  # Shoulda tests for email
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:email).is_at_least(3) }
  it { should allow_value("user@readdit.com").for(:email) }
  it { should_not allow_value("userreaddit.com").for(:email) }
  
  # Shoulda tests for password
  it { should validate_presence_of(:password) }
  it { should have_secure_password }
  it { should validate_length_of(:password).is_at_least(6) }
  
  describe "attributes" do
    it "should respond to name" do
      expect(user).to respond_to(:name)    
    end
    
    it "should respond to email" do
      expect(user).to respond_to(:email)
    end
    
    it "should respond to role" do
      expect(user).to respond_to(:role)  
    end
    
    it "should respond to admin?" do
      expect(user).to respond_to(:admin?)  
    end
    
    it "should respond to member?" do
      expect(user).to respond_to(:member?)  
    end
  end
  
  describe "roles" do
    it "should be member by default" do
      expect(user.role).to eql("member")
    end
    
    context "member user" do
      it "should return true for #member?" do
        expect(user.member?).to be_truthy
      end
      
      it "should return false for #admin?" do
        expect(user.admin?).to be_falsey  
      end
    end
    
    context "admin user" do
      before do
        user.admin!
      end
      
      it "should return false for #member?" do
        expect(user.member?).to be_falsey
      end
      
      it "should return true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end
  
  describe "invalid user" do
    let(:user_with_invalid_name) { build(:user, name: "") }
    let(:user_with_invalid_email) { build(:user, email: "") }
    let(:user_with_invalid_email_format) { build(:user, email: "invalid format") }
    
    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid    
    end
    
    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid    
    end
    
    it "should be an invalid user due to incorrectly formatted email" do
      expect(user_with_invalid_email_format).to_not be_valid
    end
  end
  
  describe "#favorite_for(post)" do
    
    before do
      topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
    end
    
    it "returns 'nil' if the user has not favorited the post" do
      expect(user.favorite_for(@post)).to be_nil  
    end
    
    it "returns the appropriate favorite if it exists" do
      favorite = user.favorites.where(post: @post).create
      expect(user.favorite_for(@post)).to eq(favorite)
    end
  end
  
  describe ".avatar_url" do
    
    let(:known_user) { create(:user, email: "readdithead@readdit.io") }
    
    it "returns the proper Gravatar url for a known email entity" do
      expected_gravatar = "http://gravatar.com/avatar/b9fdb2af8e937d65c99a342f9fbb6f60.png?s=48"
      expect(User.avatar_url(known_user, 48)). to eq(expected_gravatar)  
    end
  end
  
  describe "#generate_auth_token" do
    it "creates a token" do
      expect(user.auth_token).to_not be_nil  
    end
  end
  
end
