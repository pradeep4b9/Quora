QuoraClone::Application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      get 'sessions' => 'sessions#user_signed_in'

      post 'show_user' => 'users#show'

      post 'answer_user' => 'answers#answer_user'

      post 'question_feed' => 'questions#feed'
      post 'question_user' => 'questions#question_user'
      post 'question' => 'questions#show'
      post 'get_comments' => 'comments#index'
      post 'show_topic' => 'topics#show'
      post 'topic' => 'topics#create'
      post 'follow_topic' => 'user_topics#create'
      post 'user_topics' => 'topics#users_topics'

      resources :questions
      resources :answers
      resources :comments
      resources :topics
      resources :question_topics
      resources :user_topics
      resources :sessions
      resources :relationships

      resources :users do
        member do
          get :following, :followers
        end
      end

    end
  end
end
