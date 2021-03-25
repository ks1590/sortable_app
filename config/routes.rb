Rails.application.routes.draw do
  resources :events
  devise_for :users
  root "blogs#index"

  resources :blogs do
    collection do
      get :chart
    end
  end
  # mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
