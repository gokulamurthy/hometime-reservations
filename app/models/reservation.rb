class Reservation < ApplicationRecord
  belongs_to :guest
  has_one :reservation_guest_detail

  validates_uniqueness_of :code
  validates :start_date, presence: true
  validates :end_date, presence: true, date: { after_or_equal_to:  :start_date}
  accepts_nested_attributes_for :reservation_guest_detail

  before_save :generate_code

  protected

  def generate_code
    self.code = "#{SecureRandom.urlsafe_base64(4)}"
  end
end
