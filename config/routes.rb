Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/sign_in'
      delete 'auth/sign_out'
      put 'auth/:customer_type/:id/change_password', to: 'auth#change_password'
      post 'auth/forgot_password'
      post 'auth/reset_password'
      
      get 'export/export_to_xlsx'
      
      get 'search', to: 'search#search'
      get 'search_history', to: 'history#search_history'
      
      get 'select/cnaes'
      get 'select/company_size'
      get 'select/municipality_from_uf'
      
      get 'customer/list'
      post 'customer/new'
      # get 'customer/:id', to: 'customer#account'
      get 'customer/:id', to: 'customer#edit'
      patch 'customer/:id', to: 'customer#update'
      delete 'customer/:id', to: 'customer#delete'
      get 'customer/:id/leads_remaining', to: 'customer#leads_remaining'
      
      post 'customer_user/new'
      get 'customer_user/list'
      get 'customer_user/select_customer_users'
      put 'customer_user/enable_disable'
      get 'customer_user/:id', to: 'customer_user#edit'
      patch 'customer_user/:id', to: 'customer_user#update'
      
      get 'subscription/list'
    end
  end
end
