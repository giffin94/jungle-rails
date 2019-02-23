class ReviewsController < ApplicationController
  before_filter :authorize

  def create
    product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.product = product
    @review.save
    redirect_to product
  end

  def authorize
    current_user
  end

  private
    def review_params
      params.require(:review).permit(
        :description, 
        :rating 
      )
    end
end