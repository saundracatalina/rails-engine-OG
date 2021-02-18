require 'rails_helper'

describe 'Merchants', type: :request do
  it 'can get one merchant back by its id' do
    merchant = create(:merchant)
    id = merchant.id

    get api_v1_merchant_path(merchant)

    json = JSON.parse(response.body, symbolize_names: true)
    merchant = json[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)
    expect(merchant[:id]).to eq("#{id}")
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end
  it 'fails with 404 if merchant does not exist' do
    get api_v1_merchant_path(999999)

    expect(response.status).to eq(404)
  end
  it 'fails with 404 if merchant id sent as string' do
    merchant_id = create(:merchant).id
    get api_v1_merchant_path("merchant_id")

    expect(response.status).to eq(404)
  end
  it 'returns all records associated with a specific merchant' do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = Item.create!(name: "spoon",
                          description: "good for scooping",
                          unit_price: 1.99,
                          merchant_id: merchant.id)
    item_2 = Item.create!(name: "knife",
                          description: "good for cutting",
                          unit_price: 2.55,
                          merchant_id: merchant.id)
    item_3 = Item.create!(name: "fork",
                          description: "good for forking",
                          unit_price: 1.99,
                          merchant_id: merchant_2.id)

    get api_v1_merchant_items_path(merchant)

    json = JSON.parse(response.body, symbolize_names: true)
    merchant_items = json[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(merchant_items.count).to eq(2)
    expect(merchant_items).to eq([merchant_items[0], merchant_items[1]])
    expect(merchant_items[0][:attributes][:name]).to eq(item_1.name)
    expect(merchant_items[1][:attributes][:name]).to eq(item_2.name)
    expect(merchant_items[2]).to eq(nil)
  end
  it 'returns a 404 if no items found associated with a merchant' do
    merchant = create(:merchant)

    get api_v1_merchant_items_path(merchant)

    json = JSON.parse(response.body, symbolize_names: true)
    merchant_items = json[:data]

    expect(response.status).to eq(404)
  end
end
