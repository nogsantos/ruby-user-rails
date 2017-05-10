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
    # has_secure_password

    validates :username, :format => { :with => /\A[a-z\d_\-\.@]+\z/i }

end
