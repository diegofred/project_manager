Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # devise_for :models
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace 'api' do
    namespace 'v1' do
      resources :projects
      resources :tasks do
        collection do
          get 'in_project/:project_id', as: :in_project, action: :in_project
        end
      end
      resources :comments do
        collection do
          get 'in_task/:task_id', as: :in_task, action: :in_task
        end
      end
    end
  end
end
