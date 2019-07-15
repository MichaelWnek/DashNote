Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  devise_scope :user do
    authenticated :user do
      root "tweets#index", as: :authenticated_root
    end

    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end


  root 'tweets#index'
  
  resources :tweets do
  	resources :likes
  end

  resources :users do 
  	member do
  		get :following, :followers
  	end
  end
  
  resources :relationships, only: [:create, :destroy]
end
