class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

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

  def configure_permitted_parameters
    update_attrs = %i[first_name last_name mobile_phone created_by updated_by]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
    devise_parameter_sanitizer.permit :sign_up, keys: update_attrs
    devise_parameter_sanitizer.permit :invite, keys: update_attrs
  end
end
