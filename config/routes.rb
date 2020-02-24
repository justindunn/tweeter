Rails.application.routes.draw do
  resources :users, only: [:index, :show, :new, :edit, :update, :create] do
    collection do
      get 'tweets'
    end
    
    resources :tweets, only: :create do
      collection do
        post :search
      end
    end
  end


  root to: 'users#index'
end
