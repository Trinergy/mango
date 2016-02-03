class UserMailer < ApplicationMailer
  default from: "admin@rotten_mangoes.com"
  
  def delete_email(user)
    @user = user
    @url = "http://localhost:3000/users/new"
    mail(to: @user.email, subject: 'Say Goodybye, *redacted*')
  end
end
