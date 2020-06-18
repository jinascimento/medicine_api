module CartItemManager
  class CartItemAdder < CartItemManager::BuildCartItem

    def initialize(cart, item_attributes)
      @cart = cart
      @quantity_to_add = item_attributes[:quantity]
      @item = CartItem.find_by(medicine_id: item_attributes[:medicine_id])

    end

    def call
      @item.quantity += @quantity_to_add

      subtract_item_from_stock
      perform_calculations
      @item
    end

    private

    def subtract_item_from_stock
      medicine = Medicine.find(@item.medicine_id)
      medicine.lock!
      medicine.stock = medicine.stock - @quantity_to_add
      medicine.save!
    end

    def perform_calculations
      @item.price = cart_item_calc.price
    end

    def cart_item_calc
      cart_item_calc ||= Calcs::CartItemCalc.new(@item)
    end

  end
end