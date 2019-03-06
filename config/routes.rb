Rails.application.routes.draw do
  get 'cards/new'
  get 'cards/edit'
  devise_for :users
  root to: 'pages#home'
  resources :curriculums, only:[:show, :index] do
    resources :decks, only:[:index, :edit, :update, :new, :create] do
      resources :cards, only:[:edit, :update, :new, :create, :index, :show]
    end
  end
  resources :sections, only: :show do
    resources :decks, only: :show
  end

end
