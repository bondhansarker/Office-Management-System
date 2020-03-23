class Category < ApplicationRecord
  has_many :budgets
  has_many :expenses
  validates :name, presence: true, uniqueness: true
end
