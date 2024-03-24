Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'export/export_to_xlsx'
      get 'search', to: 'search#search'
      get 'select/cnaes'
      get 'select/company_size'
      get 'select/municipality_from_uf'
      get 'select/district_from_municipality'
      get 'search_history', to: 'history#search_history'
      post 'auth/sign_in'
      delete 'auth/sign_out'
      put 'auth/:customer_type/:id/change_password', to: 'auth#change_password'

      get 'customer_user/list'
      get 'customer_user/new'
      get 'customer_user/update'
      get 'customer_user/delete'
      
      get 'customer/list'
      post 'customer/new'
      put 'customer/update'
      get 'customer/show'
      get 'customer/delete'
    end
  end
end
