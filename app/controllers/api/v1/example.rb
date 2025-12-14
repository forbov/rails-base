# frozen_string_literal: true

module API
  module V1
    class Example < Grape::API
      include API::V1::Defaults

      resource :users do
        before { authenticate! }

        desc "Return all users"
        get do
          User.all
        end

        desc "Return a user"
        params do
          requires :id, type: String, desc: "ID of the user"
        end
        get ":id" do
          User.where(id: permitted_params[:id]).first!
        end

        desc "Create a new user"
        params do
          requires :email, type: String, desc: "Email of the user"
          requires :first_name, type: String, desc: "First name of the user"
          requires :last_name, type: String, desc: "Last name of the user"
          requires :mobile_phone, type: Integer, desc: "Mobile phone number of the user"
        end

        post "create" do
          user = User.create!(email: params[:email],
                              first_name: params[:first_name],
                              last_name: params[:last_name],
                              mobile_phone: params[:mobile_phone],
                              created_by: current_user.id,
                              updated_by: current_user.id)

          { status: "success", user: user }
        end
      end
    end
  end
end
