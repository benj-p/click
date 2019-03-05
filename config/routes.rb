Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :curriculums, only:[:show] do
    resources :sections, only: [:show] do
      resources :decks, only:[:index, :show, :new, :create, :edit] do
        resources :cards, only[:index, :new, :create, :edit]
      end
    end
  end
end
