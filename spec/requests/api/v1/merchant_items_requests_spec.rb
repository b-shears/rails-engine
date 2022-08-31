require 'rails_helper'

describe "Items API" do 
    it 'sends a list of items for a specific merchant' do 
        merchant = create(:merchant)
        create_list(:item, 3, merchant_id: merchant.id)

        get "/api/v1/merchants/#{merchant.id}/items"
        
        items = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_successful

        expect(response.status).to eq(200)
        expect(response.status).to_not eq(404)

        expect(items[:data].count).to eq(3)

        
        items[:data].each do |item|
            expect(item).to have_key(:id)
            expect(item[:id]).to be_a(String)

            expect(item[:attributes]).to have_key(:name)
            expect(item[:attributes][:name]).to be_a(String)

            expect(item[:attributes]).to have_key(:description)
            expect(item[:attributes][:description]).to be_a(String)

            expect(item[:attributes]).to have_key(:unit_price)
            expect(item[:attributes][:unit_price]).to be_a(Float)

            expect(item[:attributes]).to have_key(:merchant_id)
            expect(item[:attributes][:merchant_id]).to be_a(Integer)
        end 
    end 

    it 'can get an items merchant' do 
        merchant_1 = create(:merchant)
        item = create(:item, merchant_id: merchant_1.id)

        get "/api/v1/items/#{item.id}/merchant"

        merchant = JSON.parse(response.body, symbolize_names: true)
        # binding.pry
        expect(response).to be_successful
      
        expect(merchant[:data][:id].to_i).to eq(merchant_1.id)
        expect(merchant[:data][:attributes][:name]).to eq(merchant_1.name)
        expect(item.merchant_id).to eq(merchant[:data][:id].to_i)
        

    end 

end 