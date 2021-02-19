require 'rails_helper'

describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end
  describe 'class methods' do
    describe 'paginate' do
      it 'can take user input for per page query param' do
        item_1 = create(:item)
        item_2 = create(:item)
        item_3 = create(:item)
        data = Item.paginate(2, nil)

        expect(data).to eq([item_1, item_2])
      end
      it 'returns an array even if only 1 resource is found & per_page query is larger than number of existing records' do
        item_1 = create(:item)

        data = Item.paginate(2, nil)

        expect(data).to eq([item_1])
      end
      it 'returns an empty array even if no resources are found' do
        data = Item.paginate(5, nil)

        expect(data).to eq([])
      end
      it 'defaults to 20 resources per page if not specified by user' do
        create_list(:item, 25)

        data = Item.paginate(nil, nil)

        expect(data.size).to eq(20)
      end
      it 'defaults to page 1 if not specified by user' do
        item_1 = create(:item)
        item_2 = create(:item)
        item_3 = create(:item)
        item_4 = create(:item)

        data = Item.paginate(3, nil)

        expect(data).to eq([item_1, item_2, item_3])
      end
      it 'can take user input of a page of resources to skip before returning data' do
        item_1 = create(:item)
        item_2 = create(:item)
        item_3 = create(:item)
        item_4 = create(:item)

        data = Item.paginate(2, 2)

        expect(data).to eq([item_3, item_4])
      end
    end
    describe 'item_search' do
      it "can search for an item with a fragment of a name" do
        item_1 = create(:item, name: "FuN")
        item_2 = create(:item, name: "FunHouse")
        item_3 = create(:item, name: "house")
        search_fragment = "fUn"
        key = "name"

        data = Item.item_search(key, search_fragment)

        expect(data.length).to eq(2)
        expect(data[0]).to eq(item_1)
        expect(data[1]).to eq(item_2)
        expect(data).to_not include(item_3)
      end
    end
  end
end
