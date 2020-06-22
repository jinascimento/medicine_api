module CartItemManager
  class CartItemAdder < CartItemManager::CartItemTemplate
    attr_reader :item

    def initialize(cart, item_attributes)
      @cart = cart
      @quantity_to_add = item_attributes[:quantity]
      @item = CartItem.find_by(medicine_id: item_attributes[:medicine_id])

    end

    def call
      @item.quantity += @quantity_to_add
      ActiveRecord::Base.transaction do
        subtract_item_from_stock
        perform_calculations
        @item
      end
    end

  end
end