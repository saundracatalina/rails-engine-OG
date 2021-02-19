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
    expect(item[:attributes][:name]).to eq(item_params[:name])
    expect(item[:attributes][:description]).to eq(item_params[:description])
    expect(item[:attributes][:unit_price]).to eq(item_params[:unit_price])
    expect(item[:attributes][:merchant_id]).to eq(item_params[:merchant_id])
  end
  it 'can update an existing item' do
    id = create(:item).id
    former_name = Item.last.name
    item_params = { name: "The bestest item ever" }
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)
    json = JSON.parse(response.body, symbolize_names: true)
    item_json = json[:data]

    expect(response).to be_successful
    expect(response.status).to eq(202)
    expect(item.name).to_not eq(former_name)
    expect(item.name).to eq("The bestest item ever")
    expect(item_json[:attributes][:name]).to eq("The bestest item ever")
    expect(item_json[:attributes][:name]).to_not eq(former_name)
  end
  it 'throws a 404 error when id entered for a patch is a string' do
    id = create(:item).id
    former_name = Item.last.name
    item_params = { name: "The bestest item ever" }
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/'#{id}'", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(item.name).to eq(former_name)
    expect(response.status).to eq(404)
  end
  it 'throws a 404 error when an id that does not exist is entered for a patch' do
    item_params = { name: "The bestest item ever" }
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/99999", headers: headers, params: JSON.generate({item: item_params})

    expect(response.status).to eq(404)
  end
  it 'throws a 404 error when given a bad merchant id for a patch' do
    item = create(:item)
    item_id = item.id
    assoc_merch = item.merchant_id
    fake_merch_id = 99999

    item_params = { merchant_id: fake_merch_id }
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/#{item_id}", headers: headers, params: JSON.generate({item: item_params})

    expect(response.status).to eq(404)
  end
  it 'can destroy an item(if found)' do
    id = create(:item).id

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{id}"

    expect(response.status).to eq(204)
    expect(Item.count).to eq(0)
  end
end
