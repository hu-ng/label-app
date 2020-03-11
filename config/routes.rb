Rails.application.routes.draw do
  post 'refresh', controller: :refresh, action: :create
  post 'signin', controller: :signin, action: :create
  post 'signup', controller: :signup, action: :create
  delete 'signin', controller: :signin, action: :destroy

  namespace :api do
    namespace :v1 do
      resources :addresses, except: [:update, :destroy]
      resources :parcels, except: [:update, :destroy]
      resources :shipments, except: [:update, :destroy]
      post 'get_label', controller: :label, action: :create
    end
  end
end
