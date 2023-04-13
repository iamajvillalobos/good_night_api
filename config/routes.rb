Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :clock_in, only: [:create]
      resource :clock_out, only: [:update]
      resources :clock_ins, only: [:index]
      resources :feeds, only: [:index]
      resource :follow, only: [:create]
      resource :unfollow, only: [:destroy]
    end
  end
end
