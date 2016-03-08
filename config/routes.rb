QuoraClone::Application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      get 'sessions' => 'sessions#user_signed_in'
      delete 'sessions' => 'sessions#destroy'

      post 'show_user' => 'users#show'

      post 'answer_user' => 'answers#answer_user'

      post 'question_feed' => 'questions#feed'
      post 'question_user' => 'questions#question_user'
      post 'question' => 'questions#show'
      post 'get_comments' => 'comments#index'
      post 'comments' => 'comments#create'
      post 'show_topic' => 'topics#show'
      post 'topic' => 'topics#create'
      get 'topics' => 'topics#index'
      post 'follow_topic' => 'user_topics#create'
      post 'user_topics' => 'topics#users_topics'

      delete 'relationships' => 'relationships#destroy'

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
