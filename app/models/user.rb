class User < ActiveRecord::Base

  has_secure_password

  validates_uniqueness_of :email, :case_sensitive => false
  
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: {minimum: 4}
  validates :password_confirmation, presence: true, length: {minimum: 4}
  
  def self.authenticate_with_credentials(email, password)

    if (email == nil || password == nil) 
      return false
    end
    
    User.find_by(email: email.strip.downcase)&.authenticate(password)
  end 

end