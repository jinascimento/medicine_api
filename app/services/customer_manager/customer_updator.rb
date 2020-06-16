module CustomerManager
  class CustomerUpdator < ApplicationService

    def initialize(customer, attributes)
      @customer = customer
      @attributes = attributes
    end

    def call
      @customer.update!(@attributes)
      @customer
    end
  end
end