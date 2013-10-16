App2::Application.routes.draw do
  root "welcome#index"
  get "welcome", to: "welcome#index"
  get "welcome/index"
  get "learn/lesson1"
  get "learn/lesson2"
  post "learn/lesson3"
  get "learn/lesson3"
  get "learn/lesson4/:name", to: "learn#lesson4", constraints: {name: /[A-Za-z]+/}
  get "learn/lesson4"
  get "learn/lesson5/:num/:power", to: "learn#lesson5", constraints: {num: /\d+/, power: /\d+/ }
  get "learn/lesson6"
  get "learn/lesson7"
  get "learn/lesson8"
  get "learn/lesson9"
  post "learn/lesson10"
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
