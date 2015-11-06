include RandomData

FactoryGirl.define do
  factory :topic do
    name RandomData.random_name
    description Random.random_sentence
  end
end