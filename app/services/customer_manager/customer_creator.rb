module CustomerManager
  class CustomerCreator < ApplicationService

    def initialize(attributes)
      @attributes = attributes
    end

    def call
      customer = Customer.new(@attributes)
      customer.save!
      customer
    end
  end
end