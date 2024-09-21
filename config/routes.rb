Rails.application.routes.draw do
  resources :missions
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
  root "home#show"
end
