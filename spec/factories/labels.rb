include RandomData

FactoryGirl.define do
  factory :label do
    name {RandomData.random_word}      
  end
end
