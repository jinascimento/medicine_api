module Calcs
  class CartCalc

    def initialize(cart)
      @cart = cart
    end

    def total_amount
      cart_item_prices = []
      @cart.cart_items.each do |cart_item|
        cart_item_prices << cart_item.price
      end
      cart_item_prices.inject(:+)
    end

    def total_amount_with_discount
      discount = Calcs::DiscountCalc.new(@cart)
      discount.call
    end
  end
end