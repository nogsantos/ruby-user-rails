require 'logger'
=begin
    Controller v1 User    
=end
class V1::UsersController < V1::BaseController    
    before_action :authenticate_user!, only: [:show, :update, :destroy]
    
    def index
        begin
            if params[:status]
                user = V1::User.where(status: params[:status]).order(created_at: :desc)
            else                
                user = V1::User.all.order(created_at: :desc)
            end
            # user = apply_filters(user, params)
            # user = paginate(user)
            user = policy_scope(user)
            render(
                json: ActiveModelSerializers::SerializableResource.new(
                    user,
                    each_serializer: V1::UserSerializer,
                    root: 'users'
                ).to_json
            )            
        rescue => error
            logger.fatal(error)
            return api_error(status: 422, errors: error)            
        end
    end

    def create
        begin      
            user = V1::User.new(user_params)
            user.status = true
            if user.save            
                render(
                    json: ActiveModelSerializers::SerializableResource.new(
                        user,
                        serializer: V1::UserSerializer,
                        root: 'users'
                    ).to_json
                )
                SignupMailer.confirm_email(user).deliver
            else
                return api_error(
                    status: 422, 
                    errors: user.errors
                )
            end
        rescue => error
            logger.fatal(error)
            return api_error(status: 500)
        end        
    end

    def edit
        user = V1::User.find params[:id]
    end

    def update
        begin
            user = V1::User.find params[:id]
            if user.update_attributes(user_params)
                render(
                    json: ActiveModelSerializers::SerializableResource.new(
                        user,
                        serializer: V1::UserSerializer,
                        root: 'users'
                    ).to_json
                )
            else
                return api_error(
                    status: 422, 
                    errors: user.errors
                )
            end            
        rescue => error            
            logger.fatal(error)
            return api_error(status: 500)            
        end
    end

    def destroy
        begin
            user = V1::User.find_by(id: params[:id])            
            if user.update(status: false)
                render(
                    json: ActiveModelSerializers::SerializableResource.new(
                        user,
                        serializer: V1::UserSerializer,
                        root: 'users'
                    ).to_json
                )
            else
                return api_error(
                    status: 422, 
                    errors: user.errors
                )
            end 
        rescue => error
            logger.fatal(error)
            return api_error(status: 500)   
        end
    end

    def show
        begin
            user = V1::User.find params[:id]
            render(
                    json: ActiveModelSerializers::SerializableResource.new(
                        user,
                        serializer: V1::UserSerializer,
                        root: 'users'
                    ).to_json
                )
        rescue => error
            logger.fatal(error)
            return api_error(status: 500)   
        end
    end
    
    private
        def user_params
            params.require(:user)
                .permit(:name, :email, :password, :username, :status)
                .delete_if{ |k,v| v.nil?}
        end
end
