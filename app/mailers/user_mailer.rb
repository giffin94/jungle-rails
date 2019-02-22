class UserMailer < ApplicationMailer

  def confirmation_email(user, order)
    @user = user
    @order = order
    mail(to: @order.email, subject: "Your Order: #{order.id}")
  end

end
