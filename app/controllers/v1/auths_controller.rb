=begin
    Controller v1 Auth 
=end
class V1::AuthsController < V1::BaseController
    def create        
        user = V1::User.find_by(username: auth_params[:username])
        if user && user.authenticate(auth_params[:password])
            self.current_user = user            
            render(
                json: %w{"autenticado"},
                status: 201
            )            
        else
            return unauthenticated!        
        end        
    end

private
    def auth_params
        params.require(:user).permit(:username, :password)
    end
end
