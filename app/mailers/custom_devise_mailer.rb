
# app/mailers/custom_devise_mailer.rb
class CustomDeviseMailer < Devise::Mailer
  layout "mailer"  # This refers to app/views/layouts/mailer.html.erb
end
