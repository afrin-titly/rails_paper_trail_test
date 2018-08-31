Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  patch "versions/:id/revert" => "versions#revert", :as => "revert_version_update"
  post "versions/:id/revert" => "versions#revert", :as => "revert_version_create"
  resources :users
  root :to => "users#index"
end
