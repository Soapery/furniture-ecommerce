Rails.application.routes.draw do
  get 'home/index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Defines the About page route
  get '/about', to: 'pages#about', as: 'about'

  get '/contact', to: 'pages#contact', as: 'contact'


  # Defines the admin page route
  get '/admin', to: 'pages#admin', as: 'admin'


  get '/admin/edit_about', to: 'admin#edit_about', as: 'edit_about'
  patch '/admin/about', to: 'admin#update_about', as: 'update_about'

  # Contact content routes
  get '/admin/edit_contact', to: 'admin#edit_contact', as: 'edit_contact'
  patch '/admin/update_contact', to: 'admin#update_contact', as: 'update_contact'


  # Defines the root path route ("/")
  # root "articles#index"
  root to: "home#index"

  resources :products, only: [:index, :show, :edit, :update, :new, :create, :destroy] do
    get 'variations/:variation', to: 'products#index', on: :collection, as: :variation
    get 'search', on: :collection # Define the search route within the products resource
  end
  get '/search', to: 'products#search'



end

