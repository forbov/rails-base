class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_user, only: %i[show dashboard lock_or_unlock resend destroy]
  before_action :set_tabs, only: %i[show dashboard]


  def index
    search_name = (params[:search_name] if params[:search_name] && !params[:search_name].empty?)
    search_role = (params[:search_role] if params[:search_role] && !params[:search_role].empty?)

    @users = User.search(search_name, search_role)
  end

  def show
  end

  def dashboard
  end

  def lock_or_unlock
    notice_text = nil
    if @user.access_locked?
      @user.unlock_access!
      notice_text = "unlocked"
    else
      @user.lock_access!
      notice_text = "locked"
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

  def destroy
    @user.active = false
    @user.save
    redirect_to users_path, notice: "User was successfully deleted."
  end

  def disable_otp
    @user.otp_required_for_login = false
    @user.save!
    redirect_to users_path, notice: "Two-factor authentication disabled"
  end

  def enable_otp
    @user.otp_secret = User.generate_otp_secret
    @user.otp_required_for_login = true
    @user.save!
    redirect_to users_path, notice: "Two-factor authentication enabled"
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_tabs
    @users_all = User.all
    @users_active = User.where(active: true)
    @users_inactive = User.where(active: false)

    tabs = { users_all: { label: "All",
                          render: "users",
                          dataset: @users_all,
                          parent: @user,
                          source: "user" },
             users_active: { label: "Active",
                             render: "users",
                             dataset: @users_active,
                             parent: @user,
                             source: "user" },
             users_inactive: { label: "Inactive",
                               render: "users",
                               dataset: @users_inactive,
                               parent: @user,
                               source: "user" } }

    @bootstrap_tabs = BootstrapTabs.new(tabs, current_user, params)
  end
end
