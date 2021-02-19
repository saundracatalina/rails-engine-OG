require 'rails_helper'

describe 'Find One Merchant', type: :request do
  it 'can fetch one merchant by fragment of name' do
    merchant_1 = Merchant.create!(name: "TuRing")
    merchant_2 = Merchant.create!(name: "The Ring")
    get '/api/v1/merchants/find?name=rInG'

    json = JSON.parse(response.body, symbolize_names: true)
    merchant = json[:data]

    expect(json.length).to eq(1)
    expect(merchant.length).to eq(3)
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)
    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to be_a(String)
    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_a(Hash)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
    expect(merchant[:attributes][:name]).to eq(merchant_1.name)
    expect(merchant[:attributes][:name]).to_not eq(merchant_2.name)
  end
  it 'sad path-no fragment matched' do
    get '/api/v1/merchants/find?name=abcd'

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to be_an(Object)
  end
  it 'sad path-no fragment given'
end
