Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  devise_for :models
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace 'api' do
    namespace 'v1' do
      resources :projects
      resources :tasks
      resources :comments
    end
  end
end
