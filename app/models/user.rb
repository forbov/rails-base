class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, on: :create
  validates :first_name, presence: true, on: :create
  validates :last_name, presence: true, on: :create
  validates :mobile_phone, presence: true, uniqueness: true, on: :create

  def full_name
    "#{first_name} #{last_name}"
  end
  
  def admin?
    has_role? :SYS_ADMIN
  end

  def role_names
    roles.collect(&:name).join(", ")
  end

  def role_desc
    role_desc_str = ""
    roles.each do |role|
      role_desc_str = "#{role_desc_str}, #{role.description}"
    end
    role_desc_str[2..]
  end
end
