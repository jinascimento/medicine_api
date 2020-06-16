module CartManager
  class CartUpdator < ApplicationService

    def initialize(cart_item, attributes)
      @cart = cart_item
      @attributes = attributes
    end

    def call
      @cart.update!(@attributes)
      @cart
    end
  end
end