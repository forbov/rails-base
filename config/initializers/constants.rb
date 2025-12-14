# frozen_string_literal: true

APP_NAME = "Care-Tasker"
APP_SHORT_NAME = "Care-Tasker"
FAVICON_LOGO = "care-tasker-logo-50.png"
WELCOME_IMAGE = "care-tasker-logo-stacked-750.png"
NAVBAR_LOGO = "care-tasker-50.png"
HELPDESK_URL = "https://help.computability.com.au"
COMPUTABILITY_RESOURCES_URL = "https://resources.computability.com.au/care-tasker"

APP_HOST_URL =
  if Rails.application.config.force_ssl
    "https://#{Rails.application.config.host}"
  else
    "http://#{Rails.application.config.host}"
  end
