class EmailsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @order = Order.new
  end

  def create
    @order = Order.new(params[:order])
    if @order.valid?
      @order.get_new_content
      UserMailer.welcome_email(@order).deliver
      redirect_to root_path, notice: 'Email has been sent'
    else
      render 'index'
    end
  end

  #read uploaded file and stored to file system
  def store_file
    file = params[:order][:content]
    extension = file.content_type
    if extension == "text/html"
      Email.write_json_file(content: file.read.force_encoding('cp1252'))
      flash[:notice] = "File has been successfully stored to file system" 
    else
      flash[:error] = "File must in html format"
    end
    redirect_to root_path
  end
end
