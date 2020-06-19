# frozen_string_literal: true

module Calcs
  class DiscountCalc
    Item = Struct.new(:id, :medicine_id, :price)

    def initialize(cart)
      @cart = cart
      @total_amount = 0
    end

    def call
      separate_items
      # group_diff_items
      perform_calculation
    end

    def separate_items
      @all_items = []
      @cart.cart_items.each do |cart_item|
        if cart_item.quantity > 1
          cart_item.quantity.times do
            @all_items << Item.new(SecureRandom.uuid, cart_item.medicine_id, cart_item.price)
          end
        else
          @all_items << Item.new(SecureRandom.uuid, cart_item.medicine_id, cart_item.price)
        end
      end
      @all_items
    end

    # def group_diff_items
    #   uniq_items = @all_items.uniq(&:medicine_id)
    #   @all_items.reject! { |item| uniq_items.include?(item) }
    #   @diff_items = uniq_items
    # end

    def perform_calculation
      uniq_items = @all_items.uniq(&:medicine_id)
      if uniq_items.empty?
        return @total_amount
      end

      @all_items.reject! { |item| uniq_items.pluck(:id).include?(item.id) }
      diff_items = uniq_items

      discount_plan = DiscountPlan.find_by(different_item: diff_items.size)
      if discount_plan.nil?
        return @total_amount += Medicine.find(diff_items.first.medicine_id).value
      end

      price_medicines = []
      diff_items.each do |item|
        price_medicines << Medicine.find(item.medicine_id).value
      end
      total_price_medicines = price_medicines.inject(:+)
      discount = (total_price_medicines.to_f * discount_plan.percentage) / 100
      @total_amount += total_price_medicines - discount
      perform_calculation
    end
  end
end
