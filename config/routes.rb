Rails.application.routes.draw do
  get 'home/index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Defines the About page route
  get '/about', to: 'pages#about', as: 'about'

  # Defines the admin page route
  get '/admin', to: 'pages#admin', as: 'admin'


  # Defines the root path route ("/")
  # root "articles#index"
   root to: "home#index"


  # Product route
  resources :products, only: [:show], path: "products"
end

