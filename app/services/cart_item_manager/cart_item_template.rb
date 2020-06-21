module CartItemManager
  class CartItemTemplate < ApplicationService

    def subtract_item_from_stock
      medicine = Medicine.find(@item.medicine_id)
      medicine.lock!
      medicine.stock = medicine.stock - @item.quantity
      medicine.save!
    end

    def perform_calculations
      @item.price = cart_item_calc.price
    end

    def cart_item_calc
      @cart_item_calc ||= Calcs::CartItemCalc.new(@item)
    end

  end
end