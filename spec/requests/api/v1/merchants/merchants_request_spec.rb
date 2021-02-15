require 'rails_helper'

describe 'Merchants API request' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get api_v1_merchants_path

    expect(response).to be_successful
  end
end
