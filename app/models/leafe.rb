class Leafe < ApplicationRecord

  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :reason, presence: true
  validates :leave_type, presence: true

  LEAVE_TYPES = ["Personal Leave", "Training", "Vacation", "Medical Leave"]

  PL = "Personal Leave"
  TL = "Training"
  VL = "Vacation"
  ML = "Medical Leave"

  enum status: { pending: 0, approved: 1, rejected: 2 }

  scope :with_leafe_type, -> (type) { where(leave_type: type) }


  private

  def self.count_days(start_date,end_date)
    if start_date.present? and end_date.present?
      (start_date..end_date).select {|a| a.wday < 6 && a.wday > 0}.count
    else
      0
    end
  end


end
