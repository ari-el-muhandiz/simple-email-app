class UserMailer < ActionMailer::Base
  default from: "arifirmanto@gmail.com"

  def welcome_email(email)
    @content = email.content
    mail(to: email.to, subject: email.subject, cc: email.cc) 
  end
end
