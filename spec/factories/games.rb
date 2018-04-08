FactoryBot.define do
  factory :game do
    sequence(:name) { |n| "#{Game.default_name} #{n}" }
    sequence(:start_time) { |n| Game.defalut_start_time + n * 3600 }
  end
end
