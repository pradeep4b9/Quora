class Api::V1::TopicsController < ApplicationController

  before_filter :signed_in?

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      render json: @topic
    else
      render json: @topic.errors.full_messages, status: :unprocessable_entity
    end
  end

  def index
    @topics = Topic.all
    render :index
  end

  def show
    @topic = Topic.find(params["topic"]["id"])
    render :show
  end

  def users_topics
    @topics = User.find_by_id(params["topic"]["user_id"]).topics
    render :index
  end

  def topic_name_index
    @topics = Topic.all
    render :topic_name_index
  end

  def topic_params
    params.require(:topic).permit(:title, :description)
  end

end
