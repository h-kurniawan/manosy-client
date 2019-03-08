Rails.application.routes.draw do
  root to: "home#index"

  get "maintenance_notifications/show"
end
