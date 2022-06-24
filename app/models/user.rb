class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :foods, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def role?(requested_role)
    role == requested_role.to_s
  end
end
