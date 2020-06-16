module CartManager
  class CartBase < ApplicationService

    def subtract_item_from_stock
      @cart.cart_items.each do |cart_item|
        medicine = cart_item.medicine
        medicine.lock!
        medicine.stock = medicine.stock - cart_item.quantity
        medicine.save!
      end
    end

    def add_item_in_stock
      @cart.cart_items.each do |cart_item|
        medicine = cart_item.medicine
        medicine.lock!
        medicine.stock = medicine.stock + cart_item.quantity
        medicine.save!
      end
    end
  end
end