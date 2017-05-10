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
  # rescue => ex
  #   respond_with ex
  end

  def create
    begin
      p "teste"
      puts params

      @user = User.new(user_params)
      if @user.save
        SignupMailer.confirm_email(@user).deliver
        render json: @user
      else
        render json: "N"
      end
    rescue => e
      render json: e
    end
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

end
