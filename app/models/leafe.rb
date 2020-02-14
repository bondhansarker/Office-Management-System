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

end
