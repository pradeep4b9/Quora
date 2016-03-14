class Api::V1::CommentsController < ApplicationController

  before_filter :signed_in?

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def index
    @comments = Answer.find_by_id(comment_params[:answer_id]).comments
    render :index
  end

  def show
    @comment = Comment.includes(:answer).find(params[:id])
    render :show
  end

  def comment_params
    params.require(:comment).permit(:answer_id, :body)
  end

end
