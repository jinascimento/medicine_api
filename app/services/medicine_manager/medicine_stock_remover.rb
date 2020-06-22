module MedicineManager
  class MedicineStockRemover < ApplicationService

    def initialize(medicine, quantity)
      @medicine = medicine
      @quantity = quantity
    end

    def call
      @medicine.lock!
      @medicine.stock = @medicine.stock - @quantity
      @medicine.save!
    end

  end
end