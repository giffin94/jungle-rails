class User < ActiveRecord::Base

  has_many :reviews
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :password, :password_confirmation, presence: true, length: { minimum: 8 }
  validates :email, uniqueness: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end
