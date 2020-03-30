Rails.application.routes.draw do
  devise_for :admins, :path => '', :path_names => {:sign_in => 'signin_as_admin', :sign_out => 'signout_as_admin'}, controllers: { sessions: 'admin/sessions' }
  devise_for :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "static_pages#dashboard"

 resources :accounts
 resources :workshops
 resources :lessons do
  collection do
   patch :sort
  end
 end

 resources :workshops do
 resources :lessons
end

 namespace :admin do
  root "static_pages#dashboard"
  resources :static_pages
  resources :accounts
  resources :workshops
  resources :lessons
  resources :workshops do
   resources :lessons
  end
 end

end
