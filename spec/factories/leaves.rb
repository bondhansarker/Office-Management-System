FactoryBot.define do
  factory :leafe do
    start_date {Date.today}
    end_date {Date.today + 2.days}
    reason {"Fever"}
    leave_type {"Personal Leave"}
  end
end
