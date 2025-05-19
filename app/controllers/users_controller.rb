class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show dashboard lock_or_unlock resend]


  def index
    @users = User.all
  end

  def show
  end

  def dashboard
  end

  def lock_or_unlock
    notice_text = nil
    if @user.access_locked?
      @user.unlock_access!
      notice_text = 'unlocked'
    else
      @user.lock_access!
      notice_text = 'locked'
    end
    redirect_to users_path, notice: "User #{@user.email} access #{notice_text}"
  end

  def resend
    if @user.created_by_invite? && @user.invitation_accepted? == false
      @user.send_new_user_email(current_user)
      redirect_to users_path, notice: "User #{@user.email} re-invited"
    else
      redirect_to users_path, alert: "User #{@user.email} already active"
    end
  end  

  private
  def set_user
    @user = User.find(params[:id])
  end
end
