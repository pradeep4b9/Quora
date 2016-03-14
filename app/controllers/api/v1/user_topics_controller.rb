class Api::V1::UserTopicsController < ApplicationController

  before_filter :signed_in?

  def create
    @user_topic = UserTopic.new(
                    :topic_id => params["topic"]["id"], 
                    :user_id => current_user.id
                  )
    if @user_topic.save
      render json: @user_topic
    else
      render json: @user_topic.errors.full_messages, 
             status: :unprocessable_entity
    end
  end

  def index
    @user_topics = UserTopic.all
    render json: @user_topics
  end

  def show
    @user_topic = UserTopic.find(params[:id])
    render :show
  end

  def user_topic_params
    params.require(:topic).permit(:user_id, :topic_id)
  end

end
