Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :clock_in, only: [:create]
      resource :clock_out, only: [:update]
      resources :clock_ins, only: [:index]

      post "follow/:followee_id", to: "follows#create", as: "follow"
      delete "unfollow/:followee_id", to: "follows#destroy", as: "unfollow"

      get "feeds", to: "sleep_records#friends_sleep_records"
    end
  end
end
