Emailapp::Application.routes.draw do
  devise_for :users

  root 'home#index'

  get 'send_email' => 'home#send_email'
end
