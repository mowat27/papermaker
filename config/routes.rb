Rails.application.routes.draw do
  resources 'documents' do
    post 'generate', as: 'generate'
    get 'download', as: 'download'
  end

  namespace :api do 
    post :callback, to: "callback#create"
    put :callback, to: "callback#create"
  end

  root 'documents#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
