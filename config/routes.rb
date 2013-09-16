Emailapp::Application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => "sessions"
  }

  root 'emails#index'
  resources :emails, only: [:index, :create] do
    collection do
      post 'store_file'
    end
  end

end
