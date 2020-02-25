class Expense < ApplicationRecord

  belongs_to :user
  belongs_to :budget
  attr_accessor :remove_image

  enum status: {pending: 0, approved: 1, rejected: 2}

  validates :product_name, presence: true
  validates :expense_date, presence: true
  validates :cost, presence: true, numericality: {integer: true}


  has_attached_file :image
  validates_attachment :image,
                       content_type: {content_type: /\Aimage\/.*\z/},
                       size: {less_than: 1.megabyte},
                       styles: {orginal: "300x300#", thumb: "100x100#"},
                       source_file_options: {regular: "-density 96 -depth 8 -quality 85"},
                       convert_options: {regular: "-posterize 3"}


  before_validation :check_budget

  CATEGORY_LIST = ['Fixed', 'Regular']

  scope :sort_by_attr, -> (attr) {order(attr)}


  def update_budget

    if self.approved?
      self.budget.update({expense: self.budget.expense + self.cost})
    elsif self.pending?
      self.budget.update({expense: self.budget.expense - self.cost})
    end

  end

  private

  def check_budget
    if self.expense_date.blank?
      self.errors.add(:expense_date)
    else
      self.budget = Budget.find_by(month: self.expense_date.month, year: self.expense_date.year)
      if self.budget.blank?
        self.errors.add(:budget, :not_specified, message: " for #{Date::MONTHNAMES[self.expense_date.month]} is not submitted yet!!")
      end
    end
  end

end
