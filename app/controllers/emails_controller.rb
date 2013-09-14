class EmailsController < ApplicationController
  before_filter :authenticate_user!

  def index
    redirect_to root_path
  end

  def create
    @email = Email.new(params[:email])
    if @email.valid?
      UserMailer.welcome_email(@email).deliver
      redirect_to root_path, notice: 'Email has been sent'
    else
      render template: 'home/index'
    end
  end
end
