module V1
  module Customers
    class CartsController < ApplicationController
      before_action :set_customer, only: [:add_items]
      before_action :set_cart, only: [:show, :destroy]

      def add_items
        @cart = CartManager::AdderItem.call(@customer,
                                            cart_params[:cart_items_attributes][0])
        json_response(@cart, :created)
      end

      # GET /carts/:id
      def show
        json_response(@cart)
      end

      # DELETE /carts/:id
      def destroy
        CartManager::CartDestroyer.call(@cart)
        head :no_content
      end

      private

      def cart_params
        # whitelist params
        params.require(:cart).permit(cart_items_attributes:
                                         [:id, :medicine_id, :quantity, :_destroy])
      end

      def set_cart
        @cart = Cart.where(id: params[:id], customer_id: params[:customer_id]).first!
      end

      def set_customer
        @customer = Customer.find(params[:customer_id])
      end

    end

  end
end