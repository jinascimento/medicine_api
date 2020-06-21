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
      discounts_calculateds = []
      @ungrouped_items.size.times do |count|
        count += 1
        next if [0, 1].include?(count)
        next if count > 5
        @group_by = count
        separate_items
        perform_calculation
        discounts_calculateds << @total_amount
        @total_amount = 0
      end

      discounts_calculateds.min
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
      if combination.empty?
        return @total_amount
      end

      if discount_plan_by_group.nil?
        return @total_amount += Medicine.find(combination.first.medicine_id).value
      end

      apply_discount_on_total(price_medicines_group)
      remove_items_already_discounted
      perform_calculation
    end

    def apply_discount_on_total(total_price_medicines)
      discount = (total_price_medicines.to_f * discount_plan_by_group.percentage) / 100
      @total_amount += total_price_medicines - discount
    end

    def combination
      if @group_by == 5
        return @ungrouped_items.combination(5).to_a.first || @ungrouped_items
      elsif @group_by == 4
        return @ungrouped_items.combination(4).to_a.first || @ungrouped_items
      elsif @group_by == 3
        return @ungrouped_items.combination(3).to_a.first || @ungrouped_items
      elsif @group_by == 2
        return @ungrouped_items.combination(2).to_a.first || @ungrouped_items
      else
        @ungrouped_items
      end
    end

    def group_diff_items
      @ungrouped_items.uniq(&:medicine_id)
    end

    def remove_items_already_discounted
      @ungrouped_items.reject! { |item| combination.pluck(:id).include?(item.id) }
    end

    def discount_plan_by_group
      DiscountPlan.find_by(different_item: combination.size)
    end

    def price_medicines_group
      price_medicines = []
      combination.each do |item|
        price_medicines << Medicine.find(item.medicine_id).value
      end
      price_medicines.inject(:+)
    end
  end
end
