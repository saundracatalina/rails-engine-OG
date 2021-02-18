class Api::V1::MerchantsController< ApplicationController
  def index
    merchants = Merchant.paginate(params[:per_page], params[:page])
    render json: MerchantSerializer.new(merchants)
  end
  
  def show
    begin
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => error
      render json: {error: error.to_s}, status: :not_found
    end
  end
end
