module Calcs
  class CartItemCalc

    def initialize(cart_item)
      @cart_item = cart_item
    end

    def price
      @cart_item.quantity * @cart_item.medicine.value
    end
  end
end