require 'rails_helper'

describe 'find merchants by top_revenue' do
  it 'find a quantity of merchants sorted by descending revenue' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)
    merchant_6 = create(:merchant)

    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    item_3 = create(:item, merchant: merchant_3)
    item_4 = create(:item, merchant: merchant_4)
    item_5 = create(:item, merchant: merchant_5)
    item_6 = create(:item, merchant: merchant_6)

    invoice_1 = create(:invoice, merchant: merchant_1, status: 'shipped')
    invoice_2 = create(:invoice, merchant: merchant_2, status: 'shipped')
    invoice_3 = create(:invoice, merchant: merchant_3, status: 'shipped')
    invoice_4 = create(:invoice, merchant: merchant_4, status: 'shipped')
    invoice_5 = create(:invoice, merchant: merchant_5, status: 'shipped')
    invoice_6 = create(:invoice, merchant: merchant_6, status: 'shipped')
    invoice_7 = create(:invoice, merchant: merchant_5, status: 'shipped')


    create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 10, unit_price: 10000)
    create(:invoice_item, invoice: invoice_2, item: item_2, quantity: 10, unit_price: 1000)
    create(:invoice_item, invoice: invoice_3, item: item_3, quantity: 10, unit_price: 100)
    create(:invoice_item, invoice: invoice_4, item: item_4, quantity: 10, unit_price: 10)
    create(:invoice_item, invoice: invoice_5, item: item_5, quantity: 10, unit_price: 1)
    create(:invoice_item, invoice: invoice_6, item: item_6, quantity: 1, unit_price: 1)
    create(:invoice_item, invoice: invoice_7, item: item_5, quantity: 10, unit_price: 11000)

    create(:transaction, invoice: invoice_1, result: 'success')
    create(:transaction, invoice: invoice_2, result: 'success')
    create(:transaction, invoice: invoice_3, result: 'success')
    create(:transaction, invoice: invoice_4, result: 'success')
    create(:transaction, invoice: invoice_5, result: 'success')
    create(:transaction, invoice: invoice_6, result: 'success')
    create(:transaction, invoice: invoice_7, result: 'failed')

    get '/api/v1/revenue/merchants?quantity=5'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchants = json[:data]

    expect(json).to have_key(:data)
    expect(merchants).to be_an(Array)
    expect(merchants.count).to eq(5)
    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a(String)
      expect(merchant).to have_key(:attributes)
      expect(merchant).to be_a(Hash)
    end
    expect(merchants[0][:attributes][:name]).to eq(merchant_1.name)
    expect(merchants[1][:attributes][:name]).to eq(merchant_2.name)
    expect(merchants[2][:attributes][:name]).to eq(merchant_3.name)
    expect(merchants[3][:attributes][:name]).to eq(merchant_4.name)
    expect(merchants[4][:attributes][:name]).to eq(merchant_5.name)
    expect(merchants).to_not include(merchant_6.name)
  end
end
