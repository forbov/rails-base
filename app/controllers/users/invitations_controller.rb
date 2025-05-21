class Users::InvitationsController < Devise::InvitationsController
  def new
    @user_role = Role.find_by(name: params[:user_role_id])
    @page_title = "New #{@user_role.description}"
    @submit_label = "Invite #{@user_role.description}"
    super
  end

  def create
    user_params = params[:user]
    user_role = Role.find_by(name: user_params[:user_role_id])
    notice = nil
    email = invite_params[:email]
    user_role_id = invite_params[:user_role_id]

    existing_user = User.find_by(email:)
    user = nil

    if existing_user.present?
      user = existing_user
      notice = "User with email #{email} already exists, just adding #{user_role.description} role to the user."
    else
      user = User.invite!(invite_params,
                          current_inviter,
                          skip_invitation: true) do |u|
        u.skip_invitation = true
      end
      notice = "Invitation sent to #{email}, roles and relationships added."
    end
    user.add_role(user_role_id) unless user.has_role? user_role_id
    user.send_new_user_email(current_user)
    redirect_to users_path, notice:
  end

  def update
    super
    # set this session parameters after accepting the passwords
    session[:user_email] = @user.email
    session[:user_role] = @user.role_desc
  end

  private

  def update_resource_params
    params.require(:user).permit(:password, :password_confirmation, :user, :email, :invitation_token, :updated_by)
  end
  
end
