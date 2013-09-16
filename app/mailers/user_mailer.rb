class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(email)
    @content = email.content
    mail(to: email.to, subject: email.subject, cc: email.cc) 
  end
end
