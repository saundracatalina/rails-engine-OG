class Api::V1::ItemsController< ApplicationController
  def index
    items = Item.paginate(params[:per_page], params[:page])
    render json: ItemSerializer.new(items)
  end

  def show
    begin
      render json: ItemSerializer.new(Item.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => error
      render json: {error: error.to_s}, status: :not_found
    end
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params)), status: :created
  end

  def update
    begin
      item = Item.find(params[:id])
      item.update!(item_params)
      render json: ItemSerializer.new(item), status: :accepted
    rescue
      error = ActiveRecord::RecordNotFound
      render json: {error: error.to_s}, status: :not_found
    end
  end
  
  def destroy
    Item.destroy(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
