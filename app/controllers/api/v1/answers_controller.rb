class Api::V1::AnswersController < ApplicationController

  before_filter :signed_in?

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id

    if @answer.save
      render json: @answer
    else
      render json: @answer.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.try(:destroy)
    render json: {}
  end

  def index
    @answers = Answer.includes(:question, :comments).all
    render :index
  end

  def show
    @answer = Answer.includes(:question, :comments).find(params[:id])
    render :show
  end

  def answer_user
    @answers = User.find_by_id(params["user"]["id"]).answers

    render :index
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id, :votes)
  end

end
