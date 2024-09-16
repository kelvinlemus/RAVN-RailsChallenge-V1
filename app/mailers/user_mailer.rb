class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def trainer_inactivity
    @user = User.find(params[:user_id])
    mail(to: @user.email, subject: 'Inactivity')
  end
end