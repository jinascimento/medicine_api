module CartItemManager
  class CartItemTemplate < ApplicationService

    def subtract_item_from_stock
      MedicineManager::MedicineStockRemover.call(@item.medicine, @item.quantity)
    end

    def perform_calculations
      @item.price = cart_item_calc.price
    end

    def cart_item_calc
      @cart_item_calc ||= Calcs::CartItemCalc.new(@item)
    end

  end
end