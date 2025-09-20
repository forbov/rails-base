module UsersHelper
  def disable_otp_for_user(user)
    user.otp_required_for_login = false
    user.save!
  end

  def enable_otp_for_user(user)
    user.otp_secret = User.generate_otp_secret
    user.otp_required_for_login = true
    user.save!
  end

  def populate_otp_fields_for_users
    User.all.each do |user|
      next unless user.requires_2fa? && !user.otp_required_for_login?

      p "Enabling 2FA for user #{user.email} as their role requires 2FA"
      enable_otp_for_user(user)
    end
  end
end