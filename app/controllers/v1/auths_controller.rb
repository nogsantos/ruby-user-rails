class V1::AuthsController < ApplicationController
    def create
    user = User.find_by(username: create_params[:username])
    if user && user.authenticate(create_params[:password])
        self.current_user = user
        render(
            json: Api::V1::SessionSerializer.new(user, root: false).to_json,
            status: 201
        )
    else
        return api_error(status: 401)
    end
  end

  private
    def create_params
        params.require(:user).permit(:username, :password)
    end
end
