Rails.application.routes.draw do
  resources :listings do
    resources :bookings do
      member do
        get :cancel
      end
    end
    resources :reservations do
      member do
        get :cancel
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
