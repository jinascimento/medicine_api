module V1
  module Customers
    class CartsController < ApplicationController
      before_action :set_customer, only: [:create]
      before_action :set_cart, only: [:show, :update, :destroy]

      # POST /carts
      def create
        @cart = CartManager::CartCreator.call(@customer, cart_params)
        json_response(@cart, :created)
      end

      # GET /carts/:id
      def show
        json_response(@cart)
      end

      # PUT /carts/:id
      def update
        @cart = CartManager::CartUpdator.call(@cart, cart_params)
        json_response(@cart, :ok)
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