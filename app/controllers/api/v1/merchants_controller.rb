class Api::V1::MerchantsController< ApplicationController
  def index
    render json: Merchant.all
  end
  def show
    begin
      render json: Merchant.find(params[:id]) 
    rescue ActiveRecord::RecordNotFound => error
      render json: {error: error.to_s}, status: :not_found
    end
  end
end
