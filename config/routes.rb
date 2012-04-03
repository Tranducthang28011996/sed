Sed::Application.routes.draw do
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'edit_user_password', to: 'users#edit_password'
  get 'error', to: 'pages#error', as: 'error'
  put 'update_user_password', to: 'users#update_password'

  get 'edit_my_details', to: 'users#edit_my_details'
  get 'users/search', to: 'users#search', as: 'user_search'
  put 'update_my_details', to: 'users#update_my_details'

  resources :sessions, :only => [:new, :create, :destroy]
  resources :users do
    member do
      get :embed
    end
    resources :responses
  end
  resources :password_resets
  resources :email_confirm, :except => [:index]
  resources :surveys do
    member do
      get 'report'
    end
  end

  resources :take_surveys, :only => [:create, :show, :edit]
  get 'take_surveys/new/:id' => 'take_surveys#new', :as => :new_take_surveys

  # The priority is based upon order of creation:
  # first created -> highest priority.
  root :to => 'pages#home'

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
