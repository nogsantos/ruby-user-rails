class User < ApplicationRecord
    prepend PasswordAttribute

    validates :email, :username, :password, :name, :presence => { :message => "Campo requerido"}
    validates :email, :username, :uniqueness => {message:"Item já cadastrado"}
    validates :email, :format => {
                                :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                                :message => "Formato inválido"
                            }

    validates :password, :presence => {:message => "Campo obrigatório"}
    validates :password, :confirmation => {:message => "Falta confirmação"}
    validates :password,
                :format => {
                    :with => /(?=.*\d+)(?=.*[A-Z]+)(?=.*[a-z]+)\A.{4,}\z/,
                    :message => "Formato inválido",
                    :allow_blank => false
                }    
    validates :username, :format => { :with => /\A[a-z\d_\-\.@]+\z/i }

    before_create :generate_token

    def generate_token
        puts SecureRandom.urlsafe_base64
        # self.confirmation_token = SecureRandom.urlsafe_base64
    end
end
