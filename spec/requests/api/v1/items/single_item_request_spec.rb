require 'rails_helper'

describe 'Items', type: :request do
  it 'can get one item back by its id' do
    item = create(:item)
    id = item.id

    get api_v1_item_path(item)

    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item_json).to have_key(:id)
    expect(item_json[:id]).to be_an(Integer)
    expect(item_json[:id]).to eq(id)
    expect(item_json).to have_key(:name)
    expect(item_json[:name]).to be_a(String)
    expect(item_json).to have_key(:description)
    expect(item_json[:description]).to be_a(String)
    expect(item_json).to have_key(:unit_price)
    expect(item_json[:unit_price]).to be_a(Float)
    expect(item_json).to have_key(:merchant_id)
    expect(item_json[:merchant_id]).to be_an(Integer)    
  end
end
