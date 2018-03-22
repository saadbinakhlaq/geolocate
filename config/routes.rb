Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :locations, only: :show, defaults: { format: :json }
  root to: 'locations#show'
end
