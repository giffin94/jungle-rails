class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def has_reviews?(product)
    product.reviews.length > 0
  end
  helper_method :has_reviews?

  def sold_out?(product)
    product.quantity == 0
  end
  helper_method :sold_out?

  def average_rating(product)
    product.reviews.average(:rating).to_f.round(1)
  end
  helper_method :average_rating

  def author_current?(review)
    review.user_id == current_user.id if current_user
  end
  helper_method :author_current?

  def authorize 
    redirect_to new_session_path unless current_user
  end

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents

  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

end
