module CartItemManager
  class CartItemCreator < CartItemManager::CartItemTemplate
    attr_reader :item

    def initialize(cart, item_attributes)
      @cart = cart
      @item = CartItem.new(item_attributes)
    end

    def call
      subtract_item_from_stock
      perform_calculations
      @item
    end
  end
end