Inkunik::Application.routes.draw do
  get "cart/cart"

  get "cart/update_quantity"

  # MAIN SITE ROUTES
  # ------------------------------------
  root :to => "home#index"
  match 'categories/:parent_category_id(/:category_id(/:sub_category_id))' => "products#index", :as => :list_products
  match 'studio' => 'designs#new', :as => :studio
  match 'studio/design/total_calculate' => 'designs#total_calculate'
  match 'studio/design/:id' => 'designs#show'
  match 'api/clipart' => 'api#clipart'
  match 'api/textart' => 'api#textart'
  match 'upload_photo/create' => 'upload_photo#create'
  match 'upload_photo/my_photos' => 'upload_photo#user_uploaded_photos'
  match 'api/design2image' => 'api#design2image'
  match 'my_account' => 'account/users#index', :as => 'user_root'
  match 'account_info' => 'account/users#edit'
  match 'cart/add_to_cart' => 'checkout/cart#add_to_cart'
  match 'cart/update_cart' => 'checkout/cart#update_cart'
  match 'checkout/cart' => 'checkout/cart#index'
  match 'checkout/step1' => 'checkout/checkout#signin'
  match 'checkout/step2' => 'checkout/checkout#shipping_address'
  match 'checkout/step3' => 'checkout/checkout#shipping_method'
  match 'checkout/step4' => 'checkout/checkout#confirm'
  match 'quick_price/(:product_id)' => "products#quick_price", :as => :quick_price
  resources :products, :only => [:show]
  resources :designs, :collection => { :upload => :post }
  resources :users, :only => [:update]
  devise_for :users, :controllers => {:sessions => 'account/sessions', :registrations => 'account/registrations', :passwords => 'account/passwords'}, :skip => [:sessions] do
    get 'login' => 'account/sessions#new', :as => :new_user_session
    post 'login' => 'account/sessions#create', :as => :user_session
    get 'logout' => 'account/sessions#destroy', :as => :destroy_user_session
  end

  # ADMIN ROUTES
  # ------------------------------------
  devise_for :admins, :controllers => {:sessions => 'admin/sessions'}, :skip => [:sessions] do
    get 'admin/signin' => 'admin/sessions#new', :as => :new_admin_session
    post 'admin/signin' => 'admin/sessions#create', :as => :admin_session
    get 'admin/signout' => 'admin/sessions#destroy', :as => :destroy_admin_session
  end
  namespace :admin do
    root :to => "dashboard#index"
    resources :admins, :except => [:show]
    resources :roles, :except => [:show]
    resources :permissions, :except => [:show]
    resources :categories, :except => [:show]
    resources :products, :except => [:show]
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
