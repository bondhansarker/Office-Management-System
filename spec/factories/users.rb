FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    name {'Test Name'}
    phone {'000111'}
    target_amount 10000
    bonus_percentage 10
    password {'11111'}
    password_confirmation {'11111'}
  end
end
