require 'rails_helper'
require 'faker'

describe "Merchants API" do 
    it 'sends a list of merchants' do 
        create_list(:merchant, 3)
        
        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)
      
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
        id = create(:merchant).id 

        get "/api/v1/merchants/#{id}"

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        
        expect(merchant[:data]).to have_key(:id)
        expect(merchant[:data][:id]).to eq(id.to_s)

        expect(merchant[:data][:attributes]).to have_key(:name)
        expect(merchant[:data][:attributes][:name]).to be_a(String)

        expect(merchant[:data][:attributes]).to_not have_key(:created_at)

        expect(merchant[:data][:attributes]).to_not have_key(:updated_at)
    end 
end 
    #     it 'can create a new merchant' do 
    #         merchant_params = ({
    #                         name: 'Bob Ross'
    #                         created_at: 'date'
    #                         updated_at: 'date_2'
    #         })
        
    #         headers = {"CONTENT_TYPE" => "application/json"}
    #     end 
