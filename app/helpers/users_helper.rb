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
end