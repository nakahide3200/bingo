FactoryBot.define do
  factory :card do
    entry
    numbers Card.generate_numbers
  end
end
