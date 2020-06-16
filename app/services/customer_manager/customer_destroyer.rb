module CustomerManager
  class CustomerDestroyer < ApplicationService

    def initialize(customer)
      @customer = customer
    end

    def call
      @customer.destroy!
    end
  end
end