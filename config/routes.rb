Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session
  resource :users

  mount Rapidfire::Engine => "/rapidfire"
  root to: "rapidfire/surveys#index"
end
