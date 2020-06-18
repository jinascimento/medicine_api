module CartManager
  class CartLauncher < ApplicationService

    def initialize(customer, item_attributes)
      @cart = customer.carts.last&.opened? ? customer.carts.last : customer.carts.build
      @item_attributes = item_attributes
    end

    def call
      build_item
      perform_calculations
      @cart.save!
      @cart
    end

    private

    def build_item
      item_build = CartItemManager::BuildCartItem.new(@cart, @item_attributes)
      item_build.call
      item_build.item.new_record? ? @cart.cart_items.build(item_build.item.attributes) : item_build.item.save!
    end

    def perform_calculations
      @cart.total_amount = cart_calc.total_amount
    end

    def cart_calc
      @art_calc ||= Calcs::CartCalc.new(@cart)
    end

  end
end