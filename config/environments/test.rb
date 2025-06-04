# The test environment is used exclusively to run your application's
# test suite. You never need to work with it otherwise. Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs. Don't rely on the data there!

Rails.application.configure do
  config.host = '7burns.dyndns.org:1980' # replace with your own url
  # Settings specified here will take precedence over those in config/application.rb.

  # While tests run files are not watched, reloading is not necessary.
  config.enable_reloading = false

  # Eager loading loads your entire application. When running a single test locally,
  # this is usually not necessary, and can slow down your test suite. However, it's
  # recommended that you enable it in continuous integration systems to ensure eager
  # loading is working properly before deploying your code.
  config.eager_load = ENV["CI"].present?

  # Configure public file server for tests with cache-control for performance.
  config.public_file_server.headers = { "cache-control" => "public, max-age=3600" }

  # Show full error reports.
  config.consider_all_requests_local = true
  config.cache_store = :null_store

  # Render exception templates for rescuable exceptions and raise for other exceptions.
  config.action_dispatch.show_exceptions = :rescuable

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Store uploaded files on the local file system in a temporary directory.
  config.active_storage.service = :test

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { host: config.host }

  # SMTP settings for gmail
  # config.action_mailer.smtp_settings = {
  #   address: 'smtp.gmail.com',
  #   port: 587,
  #   user_name: Rails.application.credentials.dig(:test_smtp, :email),
  #   password: Rails.application.credentials.dig(:test_smtp, :password),
  #   domain: host,
  #   authentication: 'plain',
  #   enable_starttls_auto: true
  # }

  # Settings for sending emails via Bluehost SMTP server
  # config.action_mailer.smtp_settings = {
  #   address: 'smtp.oxcs.bluehost.com',
  #   port: 587,
  #   domain: 'computability.com.au', # Replace with your domain
  #   user_name: ENV['TEST_EMAIL_ADDRESS'], # Replace with your full Bluehost email address
  #   password: ENV['TEST_EMAIL_PASSWORD'], # Replace with your email password
  #   authentication: :plain,
  #   enable_starttls_auto: true
  # }
  # Settings for sending emails via Bluehost SMTP server
  config.action_mailer.smtp_settings = {
    address: 'mail.computability.com.au', # Replace with your Bluehost SMTP server address
    port: 465,
    user_name: ENV['TEST_CHELP_EMAIL_ADDRESS'], # Replace with your full Bluehost email address
    password: ENV['TEST_CHELP_EMAIL_PASSWORD'], # Replace with your email password
    authentication: :plain,
    enable_starttls_auto: true
  }
  config.action_mailer.perform_deliveries = true

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Raise error when a before_action's only/except options reference missing actions.
  config.action_controller.raise_on_missing_callback_actions = true
end
