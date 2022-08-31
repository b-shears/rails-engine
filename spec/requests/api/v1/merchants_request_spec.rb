require 'rails_helper'
require 'faker'

describe "Merchants API" do 
    it 'sends a list of merchants' do 
        create_list(:merchant, 3)
        
        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)
        
        expect(response.status).to eq(200)
        expect(response.status).to_not eq(404)

        expect(merchants[:data].count).to eq(3)

        merchants[:data].each do |merchant|
            expect(merchant).to have_key(:id)
            expect(merchant[:id]).to be_an(String)

            expect(merchant[:attributes]).to have_key(:name)
            expect(merchant[:attributes][:name]).to be_a(String)

            expect(merchant[:attributes]).to_not have_key(:created_at)
           

            expect(merchant[:attributes]).to_not have_key(:updated_at)
            
        end 
    end 

    it 'can get one merchant by its id' do 
        merchant_id = create(:merchant).id 

        get "/api/v1/merchants/#{merchant_id}"

        expect(response).to be_successful

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(response.status).to_not eq(404)
       
        expect(merchant[:data]).to have_key(:id)
        expect(merchant[:data][:id]).to be_a(String)

        expect(merchant[:data][:attributes]).to have_key(:name)
        expect(merchant[:data][:attributes][:name]).to be_a(String)

        expect(merchant[:data][:attributes]).to_not have_key(:created_at)

        expect(merchant[:data][:attributes]).to_not have_key(:updated_at)
    end 
end 

