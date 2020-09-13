Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :posts
      resources :recipes
    end
  end
  root 'homepage#index'
  get '*path' => 'homepage#index'
end
