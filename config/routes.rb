Rails.application.routes.draw do
  root to: 'goods#index'

  resources :goods, only: [:index] do
    collection do
      post :csv_upload
      get :upload
      get :report
    end
  end
end
