Rails.application.routes.draw do
  resources 'documents' do
    post 'generate', as: 'generate'
  end

  namespace :api do 
    resources :pdfs, only: [:update]
  end

  root 'documents#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
