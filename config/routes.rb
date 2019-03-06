Rails.application.routes.draw do
  get 'cards/new'
  get 'cards/edit'
  devise_for :users
  root to: 'pages#home'
  resources :curriculums, only:[:show] do
    resources :decks, only:[:edit, :update, :new, :create] do
      resources :cards, only:[:edit, :update, :new, :create]
    end
    resources :sections, only: [:show] do
      resources :decks, only:[:index, :show] do
        resources :cards, only:[:index, :show]
      end
    end
  end

  resources :sections, only: :show do
    resources :decks, only: :show
  end

end
