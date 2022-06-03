class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email
  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}

  private

  def downcase_email
    self.email = email.downcase
  end
end
