Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  api_version(module: 'V1', path: {value: 'v1'}) do
    resources :customers do
      resources :carts, module: :customers
    end
    resources :medicines
  end
end
