class Api::V1::QuestionsController < ApplicationController

  before_filter :signed_in?

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @question.votes = question_params[:votes]

    all_topics = Topic.pluck(:title)
    all_topic_ids = Topic.pluck(:id)

    topics = params["question"]["topics"]

    if topics.nil?
      topics = []
    end

    topic_ids = []

    topics.each do |topic| 
      index = all_topics.index(topic)
      if !index.nil?
        topic_ids << all_topic_ids[index] + 1    
      else
        new_topic = Topic.new(:title => topic)
        new_topic.save!
        topic_ids << new_topic.id
      end
    end

    if !topic_ids.empty?
      @question.topic_ids = topic_ids
    end

    if @question.save
      render :status => 200,
             :json => 
               { 
                  :success => true,
                  :info => "Question Added",
                  :data => { 
                    :id => @question.id 
                  } 
                }
    else
      render status: :unprocessable_entity
    end
  end

  def feed
    @questions = []
    @topics = User.find_by_id(question_params[:user_id]).topics
    @topics.each do |topic|
      topic.questions.each do |que|
        if que.user != current_user
          @questions << que
        end
      end
    end
    render :index
  end

  def question_user
    @questions = User.find_by_id(params["question"]["user_id"]).questions
    render :index
  end

  def show
    @question = Question.find(params["question"]["id"])
    @question.answers.reverse!
    render :show
  end

  def question_params
    params.require(:question).permit(:title, :description, :votes, :user_id)
  end
end
