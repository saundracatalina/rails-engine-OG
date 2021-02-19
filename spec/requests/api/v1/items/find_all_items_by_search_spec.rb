require 'rails_helper'

describe 'Find all items by search term', type: :request do
  it 'can fetch items by fragment of name' do
    item_1 = create(:item, name: "Fun")
    item_2 = create(:item, name: "funhouse")
    item_3 = create(:item, name: "house")

    get '/api/v1/items/find_all?name=fUn'

    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]

    expect(items.length).to eq(2)
    expect(items[0][:attributes][:name]).to eq(item_1.name)
    expect(items[1][:attributes][:name]).to eq(item_2.name)
  end
end
