module CartManager
  class CartCreator < ApplicationService

    def initialize(customer, attributes)
      @customer = customer
      @attributes = attributes
    end

    def call
      cart = @customer.carts.build(@attributes)
      cart.save!
      cart
    end
  end
end