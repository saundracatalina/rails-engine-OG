require 'rails_helper'

describe 'Merchants', type: :request do
  it 'sends a list of all merchants' do
    create_list(:merchant, 3)

    get api_v1_merchants_path

    expect(response).to be_successful
    expect(response.status).to eq(200)

    json = JSON.parse(response.body, symbolize_names: true)
    merchants = json[:data]

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
      expect(merchant[:attributes]).to_not have_key(:items)
      expect(merchant[:attributes]).to_not have_key(:invoices)
    end
  end
  it 'sends a list based on per_page and page num request' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)

    get '/api/v1/merchants?per_page=2&page=2'

    json = JSON.parse(response.body, symbolize_names: true)
    merchants = json[:data]

    expect(merchants[0][:attributes][:name]).to eq(merchant_3.name)
    expect(merchants[1][:attributes][:name]).to eq(merchant_4.name)
    expect(merchants.count).to eq(2)
  end
end
