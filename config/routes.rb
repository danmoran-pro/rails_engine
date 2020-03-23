Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      resources :customers, only: [:index, :show]
      
      resources :merchants, only: [:index, :show, :create, :update]
     
      resources :items, only: [:index, :show, :create, :update]

      resources :invoices, only: [:index, :show]
      
      resources :transactions, only: [:index, :show]
      
      resources :invoice_items, only: [:index, :show]
     
      # namespace :customers do 
      #   get '/find', to: 'find#index'
      #   get '/random', to: 'random#index'
      #   get '/find_all', to: 'find#show'
      #   get '/:id/invoices', to: 'invoices#index'
      #   get '/:id/transactions', to: 'transactions#index'
      # end 
      # namespace :merchants do 
      #   get '/find', to: 'find#index'
      #   get '/random', to: 'random#index'
      #   get '/find_all', to: 'find#show'
      #   get '/:id/invoices', to: 'invoices#index'
      #   get '/:id/transactions', to: 'transactions#index'
      # end 
      # namespace :items do 
      #   get '/find', to: 'find#index'
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
