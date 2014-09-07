Ghenio::Application.routes.draw do
  root 'home#show'
  get 'login/evernote' => 'logins#evernote'
  get 'login/github' => 'logins#github'
  get 'login/disconnect' => 'logins#disconnect'
  get 'callbacks/evernote' => 'callbacks#evernote'
  get 'callbacks/github' => 'callbacks#github'

  get 'flow/evernote_success' => 'flow#evernote_success'
  get 'flow/github_success' => 'flow#github_success'
  get 'flow/login_success' => 'flow#login_success'
  get 'flow/status' => 'flow#status'

  get 'webhooks/evernote/' => 'webhooks#evernote'

  resource :account, only: [ :new, :create ] do
    member do
      post :login
    end
  end

  resources :synchronizations, only: :create

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
