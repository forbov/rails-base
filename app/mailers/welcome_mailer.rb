# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  def new_admin_email
    @user = params[:user]
    @invitation = accept_user_invitation_url(invitation_token: params[:raw_token])
    @app_name = APP_NAME

    mail(to: @user.email,
         from: email_address_with_name(Rails.application.config.from_email, @app_name),
         subject: "Welcome to #{@app_name}")
  end

  def new_user_email
    @user = params[:user]
    @invitation = accept_user_invitation_url(invitation_token: params[:raw_token])
    @app_name = APP_NAME

    mail(to: @user.email,
         from: email_address_with_name(Rails.application.config.from_email, @app_name),
         subject: "Welcome to #{@app_name}")
  end

  def verification_email
    @otp_code = params[:otp_code]
    @user = params[:user]
    @app_name = APP_NAME
    subject = "#{@app_name} verification code"

    mail(to: @user.email,
         subject: subject,
         from: email_address_with_name(Rails.application.config.from_email, @app_name))
  end
end
