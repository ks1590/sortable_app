Rails.application.routes.draw do
  resources :events
  devise_for :users
  root "blogs#index"

  namespace :calendar do
    resources :blogs
  end
  
  resources :blogs do
    collection do
      get :chart
      # get :calendar
    end
  end
end
