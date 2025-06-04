# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  def new_admin_email
    @user = params[:user]
    @invitation = accept_user_invitation_url(invitation_token: params[:raw_token])
    @app_name = APP_NAME
    mail(to: @user.email, subject: "Welcome to #{@app_name}")
  end

  def new_user_email
    @user = params[:user]
    @invitation = accept_user_invitation_url(invitation_token: params[:raw_token])
    @app_name = APP_NAME
    mail(to: @user.email, subject: "Welcome to #{@app_name}")
  end
end
