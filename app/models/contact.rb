class Contact < ActiveRecord::Base
  # contact form validations
  validates :name, presence: true
  validates :email, presence:  true
  validates :email, inclusion: { in: %w(@ .),
  message: "%{value} isn't a valid email adress" }
  validates :message, presence: true
end