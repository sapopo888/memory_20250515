class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "【 Memory. 】会員登録完了")
  end
end
