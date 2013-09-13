Emailapp::Application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => "sessions"
  }

  root 'home#index'

  get 'send_email' => 'home#send_email'
end
