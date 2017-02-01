FactoryGirl.define do
  factory :url do
    url { Faker::Internet.url }
    code '123abc'
  end
end
