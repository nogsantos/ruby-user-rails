require "time"
require 'brnumeros'
=begin
  Comentário de bloco
=end
class UsersController < ApplicationController    
  respond_to :xml, :json  
  TESTE = "teste de constante"
  def index    
    @user = User.all

    # puts I18n.t 'wellcome'
    # num = 98.85    
    # if num == 98.85
    #   puts "R$ #{num}"
    # end
    # @user = User.new  
    # @user.id = 1
    # @user.name = "teste".upcase
    # @user.email = "asd"
    # @user.password = "passwod"
    # @user.username = 98.85.por_extenso_em_reais
    # @user.status = true
    # @user.created_at = Time.now
    # @user.updated_at = Time.now    

    respond_with @user
  rescue => ex
    respond_with ex    
  end
  
  def create
    @user = User.new 
    @user = User.create(user_params)
    respond_with @user
  rescue => e
    respond_with e
  end  

  def update
    @user.update(user_params)
    respond_with @user
  end
  
  def destroy
    @user = User.find params[:id]
    @user.destroy
    respond_with @user
  end

  def show
    @user = User.find params[:id]
    respond_with @user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :username, :status)
  end

  def imprime(par)
    t = %Q{
      Esse é apenas um teste de #{TESTE}
      #{par}
      #{sleep 1} dormir
    }
  end

  def to_s
    "User: #{@user}"
  end


end
