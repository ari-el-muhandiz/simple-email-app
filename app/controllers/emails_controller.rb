class EmailsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @email = Email.new
  end

  def create
    @email = Email.new(params[:email])
    if @email.valid?
      @email.get_new_content
      UserMailer.welcome_email(@email).deliver
      redirect_to root_path, notice: 'Email has been sent'
    else
      render 'index'
    end
  end

  #read uploaded file and stored to file system
  def store_file
    file = params[:email][:content]
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
