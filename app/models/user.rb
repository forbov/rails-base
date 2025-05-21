class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :lockable, :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, on: :create
  validates :first_name, presence: true, on: :create
  validates :last_name, presence: true, on: :create
  validates :mobile_phone, presence: true, uniqueness: true, on: :create

  attr_accessor :user_role_id
  attr_reader :raw_invitation_token

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

  def generate_token(current_user)
    if raw_invitation_token.nil?
      self.invite!(current_user) do |u|
        u.skip_invitation = true
      end
    end
  end

  def send_new_user_email(current_user)
    # Generate a new token for the user
    generate_token(current_user)

    if admin?
      WelcomeMailer.with(user: self,
                         raw_token: raw_invitation_token).new_administrator_email.deliver_later
    end
  end
end
