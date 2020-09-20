Rails.application.routes.draw do
  resources :men
  ActiveAdmin.routes(self)
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts
      resources :recipes
    end
  end
  root 'homepage#index'
  get '*path' => 'homepage#index'
end
