FactoryBot.define do
  factory :leafe do
    start_date {Date.today.beginning_of_week}
    end_date {Date.today.at_beginning_of_week + 2.days}
    reason {"Fever"}
    leave_type {"Personal Leave"}
  end
end
