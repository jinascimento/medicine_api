module CartItemManager
  class BuildCartItem < ApplicationService
    attr_reader :item

    def initialize(cart, item_attributes)
      @cart = cart
      @item_attributes = item_attributes
    end

    def call
      @item =
        if cart_already_has_the_medicine?
          CartItemManager::CartItemAdder.call(@cart, @item_attributes)
        else
          CartItemManager::CartItemCreator.call(@cart, @item_attributes)
        end
    end

    private

    def cart_already_has_the_medicine?
      @cart.cart_items.pluck(:medicine_id).include?(@item_attributes[:medicine_id])
    end

  end
end