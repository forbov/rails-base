class Users::InvitationsController < Devise::InvitationsController
  def new
    @user_role = Role.find_by(name: params[:user_role_id])
    @page_title = "New #{@user_role.description}"
    @submit_label = "Invite #{@user_role.description}"
    super
  end

  def create
    user_role = Role.find_by(name: invite_params[:user_role_id])
    notice = nil

    existing_user = User.find_by(email: invite_params[:email])
    user = nil

    if existing_user.present?
      user = existing_user
      notice = "User with email #{user.email} already exists, just adding #{user_role.description} role to the user."
    else
      user = User.new(email: invite_params[:email],
                      first_name: invite_params[:first_name],
                      last_name: invite_params[:last_name],
                      mobile_phone: invite_params[:mobile_phone],
                      created_by: invite_params[:created_by],
                      updated_by: invite_params[:updated_by])

      notice = "Invitation sent to #{user.email}, roles and relationships added."
    end

    user.add_role(user_role.name) unless user.has_role? user_role.name
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

  # This is called when creating invitation.
  # It should return an instance of resource class.
  def invite_resource
    # skip sending emails on invite
    super { |user| user.skip_invitation = true }
    # super
  end
end
