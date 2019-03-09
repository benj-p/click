Rails.application.routes.draw do
  get 'resources/new'
  get 'resources/edit'
  get 'cards/new'
  get 'cards/edit'
  devise_for :users

  root to: 'passthrough#index'

  get 'home', to: 'pages#home'

  resources :curriculums, only:[:show, :index] do
    resources :decks, only:[:index, :edit, :update, :new, :create] do
      resources :cards, only:[:edit, :update, :new, :create, :index, :show]
      resources :resources, only: [:new, :create, :edit, :update]
    end
  end

  resources :users, only: [] do
    member do
      get 'dashboard'
      get 'takedeck'
      get 'decksummary'
    end
  end
  resources :attempts, only: [:create]

  resources :sections, only: :show do
    resources :decks, only: :show do
      resources :students, only: :show
    end
  end

end
