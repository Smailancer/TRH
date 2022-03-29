Rails.application.routes.draw do

  namespace :admin do
      resources :notifications
      resources :users
      resources :comments
      resources :communities
      resources :follows
      resources :links
      resources :posts
      resources :topics

      root to: "notifications#index"
    end
  mount Notifications::Engine => "/notifications"
 
  
  get 'users/show'
  get 'comments/create'
  root 'home#index'
  get '/go/:id', to: 'posts#show'
  devise_for :users, controllers: {registrations: 'registrations'}
  resources :posts do
    resources :comments
    member do
      post :vote 
    end
  end
  resources :communities do 
    member do 
      post :follow 
      post :unfollow
    end
  end
  resources :links
  resources :topics
  resources :u, controller: 'users' do
    resources :comments, except: [:index]
    get 'comments', to: 'comments#user_comments'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
