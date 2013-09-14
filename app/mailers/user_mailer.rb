class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(email)
    @name = email.name
    @day = email.day
    @date = email.date
    @time = email.time
    @address = email.address
    mail(to: email.to, subject: email.subject, cc: email.cc) 
  end
end
