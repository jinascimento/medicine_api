# frozen_string_literal: true

module Calcs
  class DiscountCalc
    Item = Struct.new(:id, :medicine_id, :price)

    def initialize(cart)
      @cart = cart
    end

    def call
      discount_plans = []
      load_all_items.size.times do |count|
        count += 1
        next if skip_calc_discount?(count)

        @group_by = count
        @total_amount = 0

        perform_calculation
        discount_plans << @total_amount

        load_all_items
      end

      discount_plans.min
    end

    private

    def skip_calc_discount?(count)
      true if count < 2 || count > 5
    end

    def load_all_items
      @all_items = []
      @cart.cart_items.each do |cart_item|
        cart_item.quantity.times do
          @all_items << Item.new(SecureRandom.uuid, cart_item.medicine_id, cart_item.price)
        end
      end
      @all_items
    end

    def perform_calculation
      return @total_amount if combination.empty?
      return @total_amount += Medicine.find(combination.first.medicine_id).value if discount_plan_by_group.nil?

      apply_discount_on_total(price_medicines_group)
      remove_items_already_discounted
      perform_calculation
    end

    def apply_discount_on_total(total_price_medicines)
      discount = (total_price_medicines.to_f * discount_plan_by_group.percentage) / 100
      @total_amount += total_price_medicines - discount
    end

    def combination
      @all_items.combination(@group_by).to_a.first || @all_items
    end

    def group_diff_items
      @all_items.uniq(&:medicine_id)
    end

    def remove_items_already_discounted
      @all_items.reject! { |item| combination.pluck(:id).include?(item.id) }
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
