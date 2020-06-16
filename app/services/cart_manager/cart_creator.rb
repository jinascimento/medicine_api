module CartManager
  class CartCreator < CartManager::CartBase

    def initialize(customer, attributes)
      @customer = customer
      @attributes = attributes
    end

    def call
      @cart = @customer.carts.build(@attributes)
      ActiveRecord::Base.transaction do
        @cart.save!
        subtract_item_from_stock
        @cart
      end
    end
  end
end