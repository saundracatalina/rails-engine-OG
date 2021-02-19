class Api::V1::Revenue::Merchants::BusinessIntelligenceController < ApplicationController
  def top_revenue
    limit = params[:quantity]
    render json: MerchantSerializer.new(Merchant.top_merch_revenue(limit))
  end
end
