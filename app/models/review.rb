class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :user_id, :product_id, presence: true
  validates :rating, presence: true, numericality: { greater_than: 0, less_than: 6, only_integer: true }

end
