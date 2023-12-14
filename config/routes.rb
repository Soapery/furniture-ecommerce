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


  # Product route
  resources :products, only: [:show, :edit, :update, :new, :create, :destroy], path: "products"

  post '/add_to_cart/:id', to: 'cart#add_to_cart', as: 'add_to_cart'
  patch '/update_product_quantity/:id', to: 'cart#update_product_quantity', as: 'update_product_quantity'
  get '/remove_product/:id', to: 'cart#remove_product', as: 'remove_product'
  get '/cart', to: 'cart#show', as: 'cart'

  get '/confirm_order', to: 'checkout#confirm_order', as: 'confirm_order_checkout'
  get '/checkout', to: 'checkout#checkout', as: 'checkout_checkout'
  get '/order_confirmed', to: 'checkout#order_confirmed', as: 'order_confirmed'
  patch '/update_address', to: 'checkout#update_address', as: 'address_checkout'

end

