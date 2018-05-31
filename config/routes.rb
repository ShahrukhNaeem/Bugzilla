Rails.application.routes.draw do
  
#  get 'login', to: 'sessions#new'
  get 'profile', to: 'users#show'
  #get 'users/show'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root "homes#index"



####### Adding custom action in bugs controller #######

  resources :bugs do
    collection do
      get :assign_bug
      get :resolved_bug      
    end
  end
  
####### Adding custom action in bugs controller #######


####### Adding custom action in project controller #######

  resources :projects do
  	member do
  		get :add_user
      delete :delete_project_user
  		end
  	end

####### Adding custom action in project controller #######

  resources :projects
  resources :bugs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
