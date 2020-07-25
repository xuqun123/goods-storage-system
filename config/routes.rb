Rails.application.routes.draw do
  root to: 'goods#index'

  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create', as: :create_session
  delete "/logout", to: "user_sessions#destroy"

  resources :goods, only: [:index] do
    collection do
      post :csv_upload
      get :upload
      get :report
    end
  end
end
