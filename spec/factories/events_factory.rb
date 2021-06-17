FactoryBot.define do
  factory :event do
    user
    title { Faker::Name.name }
    starttime { Date.current }
    endtime { Date.tomorrow }
    description { Faker::Lorem.paragraph }
    location { Faker::Address.city }
    organizeremail { Faker::Internet.email }
    organizertelegram { Faker::Internet.username }
    link { Faker::Internet.url }
  end
end
