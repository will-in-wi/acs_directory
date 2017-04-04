Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :families, only: [:index, :show]

  root 'families#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
