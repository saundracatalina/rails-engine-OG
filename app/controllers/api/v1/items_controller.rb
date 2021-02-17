class Api::V1::ItemsController< ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end
  def show
    begin
      render json: ItemSerializer.new(Item.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => error
      render json: {error: error.to_s}, status: :not_found
    end
  end
end
