class Guest < ApplicationRecord
    has_many :reservations
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
