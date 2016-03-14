class Api::V1::UsersController < ApplicationController
  
  before_filter :signed_in?, 
                only: [:index, :edit, :update] 

  def index
    @users = User.all
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      render :status => 200,
             :json => 
               { 
                  :success => true,
                  :info => "Signed Up",
                  :data => { 
                    :remember_token => current_user.remember_token,
                    :user_id => current_user.id
                  } 
                }
    else
      render :status => 401,
             :json => 
               { 
                  :success => false,
                  :info => "Signup Error",
                  :data => { } 
                }
    end
  end
  
  def show
    @user = User.find(user_params[:id])
    render :show
  end
  
  def new
    @user = User.new
  end
  
  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, 
                                 :email, :password, :password_confirmation, 
                                 :avatar)
  end
      
end