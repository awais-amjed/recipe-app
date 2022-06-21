class User < ApplicationRecord
  has_many :foods
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def has_role?(requested_role)
    role == requested_role.to_s
  end
end
