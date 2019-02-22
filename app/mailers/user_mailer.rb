class UserMailer < ApplicationMailer

  def confirmation_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: "Your Order: #{order.id}")
  end

end
