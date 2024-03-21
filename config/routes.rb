Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/sign_in'
      delete 'auth/sign_out'
      put 'auth/:customer_type/:id/change_password', to: 'auth#change_password'

      get 'customer/list'
      post 'customer/new'
      put 'customer/update'
      get 'customer/show'
      get 'customer/delete'
    end
  end
end
