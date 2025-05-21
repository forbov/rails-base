# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  def new_administrator_email
    @user = params[:user]
    @invitation = accept_user_invitation_url(invitation_token: params[:raw_token])
    mail(to: @user.email, subject: "Welcome to Computability's Defect Management System")
  end
end
