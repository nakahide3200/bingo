FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password 'hogehoge'
    password_confirmation 'hogehoge'
  end
end
