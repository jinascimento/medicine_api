module CartManager
  class CartDestroyer < CartManager::CartBase

    def initialize(cart)
      @cart = cart
    end

    def call
      ActiveRecord::Base.transaction do
        add_item_in_stock
        @cart.destroy!
      end
    end
  end
end