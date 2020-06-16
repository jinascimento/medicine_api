module MedicineManager
  class MedicineDestroyer < ApplicationService

    def initialize(medicine)
      @medicine = medicine
    end

    def call
      @medicine.destroy!
    end
  end
end