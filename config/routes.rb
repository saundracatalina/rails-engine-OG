Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants#find'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], :controller => 'merchant_items'
      end
      get 'items/find_all', to: 'items#find_all'
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index], :controller => 'item_merchant'
      end
      namespace :revenue do
        namespace :merchants do
          get '/', to: 'business_intelligence#top_revenue'
        end
      end
    end
  end
end
