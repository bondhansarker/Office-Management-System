FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    name {'Test Name'}
    phone {'000111'}
    target_amount {10000}
    bonus_percentage {10}
    role {'Employee'}
    password {'111111'}
    password_confirmation {'111111'}
  end
end
