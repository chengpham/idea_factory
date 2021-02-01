FactoryBot.define do
  factory :idea do
    sequence(:title){ |n| Faker::Job.title + "#{n}"}
    description { Faker::Lorem.sentence(word_count: 100) }
    association(:user, factory: :user)
  end
end
