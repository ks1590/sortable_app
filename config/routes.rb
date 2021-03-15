Rails.application.routes.draw do
  resources :events
  devise_for :users
  root "blog#index"
  resources :blogs
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
