require 'rails_helper'
include RandomData

RSpec.describe Topic, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  
  it { should have_many(:posts) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  
  it { should validate_length_of(:name).is_at_least(5) }
  it { should validate_length_of(:description).is_at_least(15) }
  
  describe "attributes" do
    it "should respond to name" do
      expect(topic).to respond_to(:name)    
    end
    
    it "should respond to description" do
      expect(topic).to respond_to(:description)    
    end
    
    it "should respond to public" do
      expect(topic).to respond_to(:public)    
    end
    
    it "should be public by default" do
      expect(topic.public).to be(true)    
    end
  end
end
