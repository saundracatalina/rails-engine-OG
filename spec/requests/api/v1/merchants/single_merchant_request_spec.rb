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
end
