require 'rails_helper'

describe 'Items', type: :request do
  it 'sends a list of all items' do
    create_list(:item, 5)

    get api_v1_items_path

    expect(response).to be_successful
    expect(response.status).to eq(200)

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(5)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)
      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)
      expect(item).to have_key(:description)
      expect(item[:description]).to be_an(String)
      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_an(Float)
      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to be_an(Integer)
    end
  end
end
