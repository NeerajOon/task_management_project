class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :ensure_authentication_token
  has_many :tasks  
  
  private 
  
  def ensure_authentication_token
    self.authentication_token ||= Devise.friendly_token
  end

end


