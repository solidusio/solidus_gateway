Spree::Core::Engine.add_routes do
  resources :orders, only: [] do
    resource :checkout, controller: 'checkout' do
      member do
        get :skrill_cancel
        get :skrill_return
      end
    end
  end

  post '/skrill', to: 'skrill_status#update'
end
