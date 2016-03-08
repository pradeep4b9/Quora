class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by_email(session_params[:email])
    if user && user.authenticate(session_params[:password])
      sign_in user
      render :status => 200,
             :json => 
               { 
                  :success => true,
                  :info => "Logged in",
                  :data => { 
                    :user_id => current_user.id,
                    :remember_token => current_user.remember_token 
                  } 
                }
    else
      render :status => 401,
             :json => 
               { 
                  :success => false,
                  :info => "Invalid email or password",
                  :data => { } 
                }    
    end
  end
  
  def destroy
    if !current_user.nil?
      sign_out
      render :status => 200,
             :json => 
               { 
                  :success => true,
                  :info => "Logged out",
                  :data => { } 
                }
    else
      render :status => 401,
             :json => 
               { 
                  :success => false,
                  :info => "Not Accessible",
                  :data => { } 
                }
    end

  end

  def user_signed_in
    if !current_user.nil?
      render :status => 200,
             :json => 
               { 
                  :success => true,
                  :info => "Logged out",
                  :data => { } 
                }
    else
      render :status => 401,
             :json => 
               { 
                  :success => false,
                  :info => "Not Logged in",
                  :data => { } 
                }
    end
  end

  def session_params
    params.require(:user).permit(:email, :password, :session)
  end

end