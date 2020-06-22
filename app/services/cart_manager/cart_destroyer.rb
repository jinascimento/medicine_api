module CartManager
  class CartDestroyer < ApplicationService

    def initialize(cart)
      @cart = cart
    end

    def call
      ActiveRecord::Base.transaction do
        return_items_to_stock
        @cart.destroy!
      end
    end

    private

    def return_items_to_stock
      @cart.cart_items.each do |item|
        MedicineManager::MedicineStockAdder.call(item.medicine, item.quantity)
      end
    end

  end
end