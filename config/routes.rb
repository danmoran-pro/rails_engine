Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      resources :customers, only: [:index, :show]
      
      
      resources :transactions, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      
      namespace :merchants do 
        get '/find', to: 'find#index'
        #   get '/random', to: 'random#index'
        #   get '/find_all', to: 'find#show'
        #   get '/:id/invoices', to: 'invoices#index'
        #   get '/:id/transactions', to: 'transactions#index'
      end 
      resources :merchants, only: [:index, :show, :create, :update, :destroy] do 
        get '/items', to: 'merchants/items#index'
      end 
      
      namespace :items do 
        get '/find', to: 'find#index'
        #   get '/random', to: 'random#index'
        #   get '/find_all', to: 'find#show'
        #   get '/:id/invoices', to: 'invoices#index'
        #   get '/:id/transactions', to: 'transactions#index'
      end 
      resources :items, only: [:index, :show, :create, :update, :destroy] do 
        get '/merchant', to: 'items/merchant#index'
      end 
      

      # namespace :customers do 
      # get '/find', to: 'find#index'
      #   get '/random', to: 'random#index'
      #   get '/find_all', to: 'find#show'
      #   get '/:id/invoices', to: 'invoices#index'
      #   get '/:id/transactions', to: 'transactions#index'
      # end 
      # namespace :invoices do 
      #   get '/find', to: 'find#index'
      #   get '/random', to: 'random#index'
      #   get '/find_all', to: 'find#show'
      #   get '/:id/invoices', to: 'invoices#index'
      #   get '/:id/transactions', to: 'transactions#index'
      # end 
      # namespace :transactions do 
      #   get '/find', to: 'find#index'
      #   get '/random', to: 'random#index'
      #   get '/find_all', to: 'find#show'
      #   get '/:id/invoices', to: 'invoices#index'
      #   get '/:id/transactions', to: 'transactions#index'
      # end 
    end 
  end 
end
