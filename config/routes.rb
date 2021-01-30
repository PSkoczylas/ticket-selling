Rails.application.routes.draw do
  Rails.application.routes.draw do
    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :events do
          resources :tickets do
            resources :ticket_purchases
          end
        end
      end
    end
  end
end
