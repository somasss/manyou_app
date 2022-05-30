class User < ApplicationRecord
  before_validation { email.downcase! }
  before_destroy :has_adminuser
  before_update :has_adminuser_update
  has_secure_password
  has_many :tasks, dependent: :destroy
  validates :admin, inclusion:{in: [true, false]}
  validates :name, 
    presence: true,
    length: { maximum: 30 }
  validates :email, 
    presence: true, 
    uniqueness: true , 
    length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :password, 
      length: { minimum: 6 }

  private
  def has_adminuser
    throw(:abort) if User.where(admin: true).count <= 1 && self.admin == true
  end

  def has_adminuser_update
    throw(:abort) if User.where(admin: true).count <= 1 && self.admin == false
  end
end
