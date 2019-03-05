Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :curriculums, only:[:show] do
    resources :decks, only:[:index, :show]
  end
  resources :users, only: [] do
    member do
      get 'dashboard'
    end
  end
end
