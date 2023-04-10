Rails.application.routes.draw do
  scope module: :api do
    scope module: :v1 do
      post "clock_in", to: "sleep_records#create"
      put "clock_out", to: "sleep_records#update"
    end
  end
end
