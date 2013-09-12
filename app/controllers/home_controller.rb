class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def send_email
    UserMailer.welcome_email.deliver
    redirect_to root_path, notice: 'Email has been sent'
  end
end
