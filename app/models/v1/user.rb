=begin
    Model v1 User    
=end
class V1::User < ActiveRecord::Base
    
    validates :email, :username, :password, :name, :presence => { :message => "Campo requerido"}
    validates :email, :username, :uniqueness => {message:"Item já cadastrado"}
    validates :email, :format => {
                                :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                                :message => "Formato inválido"
                            }
    validates :password, :presence => {:message => "Campo obrigatório"}    
    validates :password, length: { minimum: 6, :message => "Tamanho mínimo 6 caracteres"}, allow_blank: true    
    validates :password_confirmation, :presence => true
    validates :username, :format => { :with => /\A[a-z\d_\-\.@]+\z/i }

    has_secure_password
    before_save   :downcase_email
    # before_create :generate_token

    # def generate_token
    #     puts SecureRandom.urlsafe_base64
    #     # self.confirmation_token = SecureRandom.urlsafe_base64
    # end

    # Returns a random token.
    # def User.new_token
    #     SecureRandom.urlsafe_base64
    # end

    # Returns the hash digest of the given string.
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Remembers a user in the database for use in persistent sessions.
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end

    # Returns true if the given token matches the digest.
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    # Autenticate method
    def authenticate?(username, password)
        puts hash password
        user = V1::User.find_by(username: username, password: hash(password), status: true)        
        return user
    end
    
    private

        # Converts email to all lower-case.
        def downcase_email
            self.email = email.downcase
        end

        # Encript password
        # def encript_password
        #     self.password = hash(password)
        # end

        # # Returns the hash digest of the given string.
        # def hash(string)
        #     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        #     BCrypt::Password.create(string, cost: cost)
        # end

        # Creates and assigns the activation token and digest.
        def create_activation_digest
            self.activation_token  = User.new_token
            self.activation_digest = User.digest(activation_token)
        end

        def generate_authentication_token
            loop do
                self.authentication_token = SecureRandom.base64(64)
                break unless User.find_by(authentication_token: authentication_token)
            end
        end
end
