class Api::V1::QuestionTopicsController < ApplicationController

  before_filter :signed_in?

  def create
    @question_topic = QuestionTopic.new(question_topic_params)

    if @question_topic.save
      render json: @question_topic
    else
      render json: @question_topic.errors.full_messages, 
             status: :unprocessable_entity
    end
  end

  def index
    @question_topics = QuestionTopic.includes(:question, :topic).all
    render json: @question_topics
  end

  def show
    @question_topic = QuestionTopic.includes(:question, :topic).
                      find(params[:id])
    render :show
  end

  def question_topic_params
    params.require(:question_topic).permit(:question_id, :topic_id)
  end

end
