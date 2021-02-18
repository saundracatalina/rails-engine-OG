require 'rails_helper'

describe 'Items', type: :request do
  it 'sends a list of all items' do
    create_list(:item, 5)

    get api_v1_items_path

    expect(response).to be_successful
    expect(response.status).to eq(200)

    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]

    expect(items.count).to eq(5)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end
  it 'sends a list based on per_page and page num request' do
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)
    item_4 = create(:item)

    get '/api/v1/items?per_page=2&page=2'

    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]

    expect(items[0][:attributes][:name]).to eq(item_3.name)
    expect(items[1][:attributes][:name]).to eq(item_4.name)
    expect(items.count).to eq(2)
  end
end
