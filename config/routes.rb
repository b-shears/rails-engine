Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 

      resources :merchants, only: [:index, :show] do 
        get 'find', to: 'merchants#find'
        resources :items, only: [:index], controller: :merchant_items 
      end 
      resources :items, only: [:index, :show, :create, :update, :destroy] do 
        resources :merchant, only: [:index], controller: :item_merchant
      end 
    end
  end 
end

