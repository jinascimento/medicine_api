module CartManager
  class CartDestroyer < ApplicationService

    def initialize(cart)
      @cart = cart
    end

    def call
      @cart.destroy!
    end
  end
end