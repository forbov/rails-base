# frozen_string_literal: true

module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix 'api'
        version 'v1', using: :path
        default_format :json
        format :json

        helpers do
          def permitted_params
            @permitted_params ||= declared(params,
                                           include_missing: false)
          end

          def logger
            Rails.logger
          end

          def current_user
            @current_user ||= User.find_by(api_token: headers['Authorisation']) if headers['Authorisation'].present?
          end

          def authenticate!
            error!('401 Unauthorized', 401) unless current_user
          end
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error!(e.message, 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error!(e.message, 422)
        end
      end
    end
  end
end
