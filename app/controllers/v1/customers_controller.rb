class V1::CustomersController < ApplicationController

  before_action :set_customer, only: [:show, :update, :destroy]

  # GET /customers
  def index
    @customer = pagination(Customer.all)
    json_response(@customer)
  end

  # POST /customers
  def create
    @customer = CustomerManager::CustomerCreator.call(customer_params)
    json_response(@customer, :created)
  end

  # GET /customers/:id
  def show
    json_response(@customer)
  end

  # PUT /customers/:id
  def update
    @customer = CustomerManager::CustomerUpdator.call(@customer, customer_params)
    json_response(@customer, :ok)
  end

  # DELETE /customers/:id
  def destroy
    CustomerManager::CustomerDestroyer.call(@customer)
    head :no_content
  end

  private

  def customer_params
    # whitelist params
    params.permit(:name)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

end
