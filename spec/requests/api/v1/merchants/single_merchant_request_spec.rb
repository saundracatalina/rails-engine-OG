require 'rails_helper'

describe 'Merchants', type: :request do
  it 'can get one merchant back by its id' do
    merchant = create(:merchant)
    id = merchant.id
    get api_v1_merchant_path(merchant)

    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(merchant_json).to have_key(:id)
    expect(merchant_json[:id]).to be_an(Integer)
    expect(merchant_json[:id]).to eq(id)
    expect(merchant_json).to have_key(:name)
    expect(merchant_json[:name]).to be_a(String)
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
