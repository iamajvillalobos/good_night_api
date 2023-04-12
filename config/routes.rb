Rails.application.routes.draw do
  scope module: :api do
    scope module: :v1 do
      post "clock_in", to: "sleep_records#create"
      put "clock_out", to: "sleep_records#update"
      get "clock_ins", to: "sleep_records#index"

      post "follow/:followee_id", to: "follows#create", as: "follow"
      delete "unfollow/:followee_id", to: "follows#destroy", as: "unfollow"

      get "feeds", to: "sleep_records#friends_sleep_records"
    end
  end
end
