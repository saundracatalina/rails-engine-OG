class Api::V1::ItemMerchantController < ApplicationController
  def index
    begin
      render json: MerchantSerializer.new(Item.find(params[:item_id]).merchant)
    rescue ActiveRecord::RecordNotFound => error
      render json: {error: error.to_s}, status: :not_found
    end
  end
end
