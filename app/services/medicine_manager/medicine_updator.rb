module MedicineManager
  class MedicineUpdator < ApplicationService

    def initialize(medicine, attributes)
      @medicine = medicine
      @attributes = attributes
    end

    def call
      @medicine.update!(@attributes)
      @medicine
    end
  end
end