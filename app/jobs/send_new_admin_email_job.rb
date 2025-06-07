class SendNewAdminEmailJob < ApplicationJob
  queue_as :default

  def perform(user, raw_token)
    p "Sending new admin email to #{user.email} with token: #{raw_token} at #{Time.current}"
    WelcomeMailer.with(user: user, raw_token: raw_token).new_admin_email.deliver_now
    p "New admin email sent to #{user.email} at #{Time.current}"
  end
end
