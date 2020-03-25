FactoryBot.define do
  factory :income do
    amount {20000}
    income_date {Faker::Date.between(from: 20.days.ago, to: Date.today)}
    source {"Employee"}
  end
end
