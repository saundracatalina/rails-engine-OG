require 'rails_helper'

describe 'Items', type: :request do
  it 'can get one item back by its id' do
    item = create(:item)
    id = item.id

    get api_v1_item_path(item)

    json = JSON.parse(response.body, symbolize_names: true)
    item = json[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)
    expect(item[:id]).to eq("#{id}")
    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_an(Integer)
  end
  it 'fails with 404 if item does not exist' do
    get api_v1_merchant_path(999999)

    expect(response.status).to eq(404)
  end
  it 'fails with 404 if item id sent as string' do
    item_id = create(:item).id
    get api_v1_merchant_path("item_id")

    expect(response.status).to eq(404)
  end
end
