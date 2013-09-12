class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email
    mail(to: 'arifirmanto@gmail.com', subject: 'Welcome to My Website') 
  end
end
