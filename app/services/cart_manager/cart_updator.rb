module CartManager
  class CartUpdator < CartManager::CartBase

    def initialize(cart, attributes)
      @cart = cart
      @attributes = attributes
    end

    def call
      ActiveRecord::Base.transaction do
        @cart.update!(@attributes)
        subtract_item_from_stock
        @cart
      end
    end
  end
end