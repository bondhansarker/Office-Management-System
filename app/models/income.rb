class Income < ApplicationRecord
  belongs_to :user
  validates :amount, :presence => true, numericality: {decimal: true}
  validates :income_date, :presence => true
  validates :source, :presence => true

  MONTHS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ,11, 12]
  SOURCE = ['Employee', 'Service']

  private
  def self.search(user_id, month, year, status)
    i = self.joins(:user).where(user_id: user_id, status: status)
    if not month.nil?
      i = i.where('extract(month from income_date) = ?', month)
    end
    if year.nil?
      i = i.where('extract(year from income_date) = ?', Date.today.year)
    else
      i = i.where('extract(year from income_date) = ?', year)
    end
    return i
  end

end
