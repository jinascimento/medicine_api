class V1::MedicinesController < ApplicationController

  before_action :set_medicine, only: [:show, :update, :destroy]

  # GET /medicines
  def index
    @medicine = Medicine.all.paginate(page: params[:page],
                                      per_page: params[:per_page])
    json_response(@medicine)
  end

  # POST /medicines
  def create
    @medicine = MedicineManager::MedicineCreator.call(medicine_params)
    json_response(@medicine, :created)
  end

  # GET /medicines/:id
  def show
    json_response(@medicine)
  end

  # PUT /medicines/:id
  def update
    @medicine = MedicineManager::MedicineUpdator.call(@medicine, medicine_params)
    json_response(@medicine, :ok)
  end

  # DELETE /medicines/:id
  def destroy
    MedicineManager::MedicineDestroyer.call(@medicine)
    head :no_content
  end

  private

  def medicine_params
    # whitelist params
    params.require(:medicine).permit(:name, :value, :quantity, :stock)
  end

  def set_medicine
    @medicine = Medicine.find(params[:id])
  end

end
