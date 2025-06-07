class SendNewUserEmailJob < ApplicationJob
  queue_as :default

  def perform(user, raw_token)
    p "Sending new user email to #{user.email} with token: #{raw_token} at #{Time.current}"
    WelcomeMailer.with(user: user, raw_token: raw_token).new_user_email.deliver_now
    p "New user email sent to #{user.email} at #{Time.current}"
  end
end
