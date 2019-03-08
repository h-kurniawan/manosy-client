Rails.application.routes.draw do
  root to: "home#index"

  resources :maintenance_notifications, only: :show do
    member do
      get :review
    end
  end
end
