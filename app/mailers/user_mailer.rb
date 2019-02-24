class UserMailer < ApplicationMailer
  def confirmation_email(user, order)
    @user = user
    @order = order
    mail(to: @order.email, subject: "Your Order: #{order.id}")
  end

  def order_total
    (@order.line_items.map { |item| item.product.price * item[:quantity] }).inject(:+)
  end
  helper_method :order_total

end
