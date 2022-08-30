require 'rails_helper'

describe "Items API" do 
    it 'sends a list of items for a specific merchant' do 
        merchant = create(:merchant)
        create_list(:item, 3, merchant_id: merchant.id)

        get "/api/v1/merchants/#{merchant.id}/items"
        
        items = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(items[:data].count).to eq(3)

        
        items[:data].each do |item|
            expect(item).to have_key(:id)
            expect(item[:id]).to be_a(String)

            expect(item[:attributes]).to have_key(:name)
            expect(item[:attributes][:name]).to be_a(String)
        end 
    end 

end 