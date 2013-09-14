class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @email = Email.new
  end

end
