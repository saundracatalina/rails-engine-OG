class Api::V1::MerchantItemsController < ApplicationController
  def index
    if Merchant.find(params[:merchant_id]).items.empty?
      error = ActiveRecord::RecordNotFound
      render json: {error: error.to_s}, status: :not_found
    else
      render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
    end
  end
end
