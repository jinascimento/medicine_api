module CartManager
  class AdderItem < ApplicationService

    def initialize(customer, cart_item)
      @quantity_cart_item = cart_item[:quantity]
      @cart_item = CartItem.find_or_initialize_by(medicine_id: cart_item[:medicine_id])
      @cart = customer.carts.last&.opened? ? customer.carts.last : customer.carts.build
    end

    def call
      ActiveRecord::Base.transaction do
        add_cart_items
        subtract_item_from_stock
        @cart.save!
        @cart
      end
    end

    private

    def add_cart_items
      if cart_already_has_the_medicine?
        update_quantity
      else
        @cart_item.quantity = @quantity_cart_item
        @cart.cart_items.build(@cart_item.attributes)
      end
    end

    def cart_already_has_the_medicine?
      @cart.cart_items.pluck(:medicine_id).include?(@cart_item.medicine_id)
    end

    def update_quantity
      @cart_item.update!(quantity: @cart_item.quantity + @quantity_cart_item)
    end

    def subtract_item_from_stock
      medicine = Medicine.find(@cart_item.medicine_id)
      medicine.lock!
      medicine.stock = medicine.stock - @quantity_cart_item
      medicine.save!
    end
  end
end