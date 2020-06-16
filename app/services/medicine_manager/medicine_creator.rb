module MedicineManager
  class MedicineCreator < ApplicationService

    def initialize(attributes)
      @attributes = attributes
    end

    def call
      medicine = Medicine.new(@attributes)
      medicine.save!
      medicine
    end
  end
end