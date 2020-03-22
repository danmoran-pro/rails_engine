Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      resources :customers, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      namespace :customers do 
        get '/find', to: 'find#index'
        get '/random', to: 'random#index'
        get '/find_all', to: 'find#show'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
      end 
      namespace :merchants do 
        get '/find', to: 'find#index'
        get '/random', to: 'random#index'
        get '/find_all', to: 'find#show'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
      end 
    end 
  end 
end
