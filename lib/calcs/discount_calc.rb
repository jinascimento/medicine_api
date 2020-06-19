# frozen_string_literal: true
require 'factorial'

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
      @ungrouped_items = []
      @cart.cart_items.each do |cart_item|
        cart_item.quantity.times do
          @ungrouped_items << Item.new(SecureRandom.uuid, cart_item.medicine_id, cart_item.price)
        end
      end
      @ungrouped_items
    end

    def perform_calculation
      if group_diff_items.empty?
        return @total_amount
      end

      if discount_plan_by_group.nil?
        return @total_amount += Medicine.find(group_diff_items.first.medicine_id).value
      end

      apply_discount_on_total(price_medicines_group)
      remove_items_already_discounted
      perform_calculation
    end

    def apply_discount_on_total(total_price_medicines)
      discount = (total_price_medicines.to_f * discount_plan_by_group.percentage) / 100
      @total_amount += total_price_medicines - discount
    end

    def group_diff_items
      @ungrouped_items.uniq(&:medicine_id)
    end

    def remove_items_already_discounted
      @ungrouped_items.reject! { |item| group_diff_items.pluck(:id).include?(item.id) }
    end

    def discount_plan_by_group
      DiscountPlan.find_by(different_item: group_diff_items.size)
    end

    def price_medicines_group
      price_medicines = []
      group_diff_items.each do |item|
        price_medicines << Medicine.find(item.medicine_id).value
      end
      price_medicines.inject(:+)
    end
  end
end
