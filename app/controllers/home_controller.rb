class HomeController < ApplicationController
  def welcome
    if user_signed_in? 
      redirect_to dashboard_user_path(current_user)
    else
      render 'welcome'
    end
  end
end
