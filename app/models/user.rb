class User < ApplicationRecord

  has_many :expenses
  has_many :incomes
  has_many :budgets
  has_many :leaves
  has_one :allocated_leafe
  has_many :attendances

  has_attached_file :image
  validates_attachment :image,
                       content_type: {content_type: /\Aimage\/.*\z/},
                       size: {less_than: 1.megabyte},
                       styles: {orginal: "300x300#", thumb: "100x100#"},
                       source_file_options: {regular: "-density 96 -depth 8 -quality 85"},
                       convert_options: {regular: "-posterize 3"}


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :name, presence: true
  validates :phone, presence: true
  validates :target_amount, presence: true, numericality: {integer: true}
  validates :bonus_percentage, presence: true, numericality: {integer: true}

  ADMIN = "Admin"
  SUPER_ADMIN = "Super Admin"
  EMPLOYEE = "Employee"
  DESIGNATION_LIST = ['Junior Software Engineer', 'Senior Software Engineer', 'Office Admin', 'Chief Executive Officer', 'Chief Technical Officer']
  ROLE_LIST = ['Super Admin', 'Admin', 'Employee']

  after_create :send_message

  def admin?
    self.role == ADMIN
  end

  def super_admin?
    self.role == SUPER_ADMIN
  end

  def employee?
    self.role == EMPLOYEE
  end

  private

  def send_message
    UserMailer.welcome(self).deliver_now
  end


end
