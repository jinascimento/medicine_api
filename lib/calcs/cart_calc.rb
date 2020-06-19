module Calcs
  class CartCalc

    def initialize(cart)
      @cart = cart
    end

    def total_amount
      if has_different_items?
        total_amount_with_discount
      else
        total_amount_without_discount
      end
    end

    private

    def has_different_items?
      @cart.cart_items.uniq(&:medicine_id).count > 1
    end

    def total_amount_without_discount
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