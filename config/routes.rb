Rails.application.routes.draw do
  get 'home/index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # Defines the root path route ("/")
  # root "articles#index"
   root to: "home#index"
end
