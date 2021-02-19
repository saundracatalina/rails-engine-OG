require 'rails_helper'

describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end
  describe 'class methods' do
    describe 'paginate' do
      it 'can take user input for per page query param' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)
        data = Merchant.paginate(2, nil)

        expect(data).to eq([merchant_1, merchant_2])
      end
      it 'returns an array even if only 1 resource is found & per_page query is larger than number of existing records' do
        merchant_1 = create(:merchant)

        data = Merchant.paginate(2, nil)

        expect(data).to eq([merchant_1])
      end
      it 'returns an empty array even if no resources are found' do
        data = Merchant.paginate(5, nil)

        expect(data).to eq([])
      end
      it 'defaults to 20 resources per page if not specified by user' do
        create_list(:merchant, 25)

        data = Merchant.paginate(nil, nil)

        expect(data.size).to eq(20)
      end
      it 'defaults to page 1 if not specified by user' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)
        merchant_4 = create(:merchant)

        data = Merchant.paginate(3, nil)

        expect(data).to eq([merchant_1, merchant_2, merchant_3])
      end
      it 'can take user input of a page of resources to skip before returning data' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)
        merchant_4 = create(:merchant)

        data = Merchant.paginate(2, 2)

        expect(data).to eq([merchant_3, merchant_4])
      end
    end
    describe 'merch_search' do
      it 'can search for a merchant with a fragment of a name' do
        merchant_1 = Merchant.create!(name: "TuRing")
        merchant_2 = Merchant.create!(name: "The Ring")
        search_fragment = "rIng"
        key = "name"

        data = Merchant.merch_search(key, search_fragment)

        expect(data).to eq(merchant_1)
        expect(data).to_not eq(merchant_2)
      end
    end
    describe 'top_merch_revenue' do
      it 'returns merchants with top revenue in desc order' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)

        item_1 = create(:item, merchant: merchant_1)
        item_2 = create(:item, merchant: merchant_2)
        item_3 = create(:item, merchant: merchant_3)

        invoice_1 = create(:invoice, merchant: merchant_1, status: 'shipped')
        invoice_2 = create(:invoice, merchant: merchant_2, status: 'shipped')
        invoice_3 = create(:invoice, merchant: merchant_3, status: 'shipped')

        create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 10, unit_price: 10000)
        create(:invoice_item, invoice: invoice_2, item: item_2, quantity: 10, unit_price: 1000)
        create(:invoice_item, invoice: invoice_3, item: item_3, quantity: 10, unit_price: 100)

        create(:transaction, invoice: invoice_1, result: 'success')
        create(:transaction, invoice: invoice_2, result: 'success')
        create(:transaction, invoice: invoice_3, result: 'success')

        limit = 2
        data = Merchant.top_merch_revenue(limit)

        expect(data).to eq([merchant_1, merchant_2])
      end
    end
  end
end
