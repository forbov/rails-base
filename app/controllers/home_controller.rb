class HomeController < ApplicationController
  before_action :set_user, only: %i[otp_entry verify_otp]

  def welcome
    if user_signed_in? 
      redirect_to dashboard_user_path(current_user)
    else
      render 'welcome'
    end
  end

  def otp_entry; end

  def verify_otp
    if @user.validate_and_consume_otp!(params[:otp_attempt])
      sign_in(@user)
      session.delete(:otp_token)
      redirect_to after_sign_in_path_for(@user), notice: 'Signed in successfully.'
    else
      redirect_to login_path, alert: 'Invalid two-factor code, please sign-in again.'
    end
  end

  private

  def set_user
    @user = User.find(session[:otp_token]) if session[:otp_token]
  end
end
