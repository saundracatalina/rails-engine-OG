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
  it 'returns an array of data even if 1 resource is found'
  it 'returns an array of data even if no resources are found'

end
