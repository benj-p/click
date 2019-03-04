Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :curriculums, only:[:show] do
    resources :decks, only:[:index, :show]
  end
end
