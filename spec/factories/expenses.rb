FactoryBot.define do
  factory :expense do
    product_name {'Expense name'}
    expense_date {'2020-01-01'}
    cost {10000}
  end
end
