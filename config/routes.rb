Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  api_version(module: 'V1', path: {value: 'v1'}) do
    resources :customers do
      resources :carts, module: :customers do
        collection do
          post 'add_items'
        end
      end
    end
    resources :medicines
  end
end
