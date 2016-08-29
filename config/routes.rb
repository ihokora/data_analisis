Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  post '/analisis',    to: 'datasets#analisis'
  post '/correlation', to: 'datasets#correlation'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
