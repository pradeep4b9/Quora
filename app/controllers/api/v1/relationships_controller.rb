class Api::V1::RelationshipsController < ApplicationController

  before_filter :signed_in?

  def create
    @user = User.find(params["relationships"]["followed_id"])
    if current_user.follow!(@user)
      render :status => 200,
             :json => 
               { 
                  :success => true
                }
    else
      render :status => 401,
             :json => 
               { 
                  :success => false
                }
    end
  end

  def destroy
    @user = User.find(params["id"])
    if current_user.unfollow!(@user)
      render :status => 200,
             :json => 
               { 
                  :success => true
                }
    else
      render :status => 401,
             :json => 
               { 
                  :success => false
                }
    end
  end
end