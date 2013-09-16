class UserMailer < ActionMailer::Base
  default from: "gaurav@taxipixi.com"

  def welcome_email(email)
    @content = email.content
    mail(to: email.to, subject: email.subject, cc: email.cc) 
  end
end
