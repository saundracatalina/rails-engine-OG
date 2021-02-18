require 'rails_helper'

describe 'Items', type: :request do
  it 'can create a new item' do
    merchant = create(:merchant)
    item_params = ({
                    "name": "value1",
                    "description": "value2",
                    "unit_price": 100.99,
                    "merchant_id": merchant.id
                    })
    headers = {'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last
    json = JSON.parse(response.body, symbolize_names: true)
    item = json[:data]

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end
  it 'throws an error if any attributes are missing'
  it 'ignores any extra attributes sent in request that are not allowed'
  it 'can update an existing item' do
    id = create(:item).id
    former_name = Item.last.name
    item_params = { name: "The bestest item ever" }
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(former_name)
    expect(item.name).to eq("The bestest item ever")
  end
end
