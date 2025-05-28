# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AppHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def configure_permitted_parameters
    additional_attributes = %i[first_name last_name mobile_phone time_zone user_role_id created_by updated_by]
    devise_parameter_sanitizer.permit :account_update, keys: additional_attributes
    devise_parameter_sanitizer.permit :sign_up, keys: additional_attributes
    devise_parameter_sanitizer.permit :invite, keys: additional_attributes
  end

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, alert: "Access denied. You are not authorized to access the requested page."
  end

  protected

  def authenticate_user!(opts = {})
    if user_signed_in?
      super
    else
      redirect_to root_path
      # redirect_to login_path, :notice => 'Login to access TOMS'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def after_sign_in_path_for(resource)
    session[:user_email] = current_user.email
    session[:user_role] = current_user.role_desc
    root_path(resource)
  end
end
