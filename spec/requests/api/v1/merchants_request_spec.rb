require 'rails_helper'
require 'faker'

describe "Merchants API" do 
    it 'sends a list of merchants' do 
        create_list(:merchant, 3)
        
        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)
      
        expect(merchants.count).to eq(3)

        merchants.each do |merchant|
            expect(merchant).to have_key(:id)
            expect(merchant[:id]).to be_an(Integer)

            expect(merchant).to have_key(:name)
            expect(merchant[:name]).to be_a(String)

            expect(merchant).to have_key(:created_at)
            expect(merchant[:created_at]).to be_a(String) 

            expect(merchant).to have_key(:updated_at)
            expect(merchant[:updated_at]).to be_a(String)
        end 
    end 

    it 'can get one merchant by its id' do 
        id = create(:merchant).id 

        get "/api/v1/merchants/#{id}"

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to eq(id)

        expect(merchant).to have_key(:name)
        expect(merchant[:name]).to be_a(String)

        expect(merchant).to have_key(:created_at)
        expect(merchant[:created_at]).to be_a(String)

        expect(merchant).to have_key(:updated_at)
        expect(merchant[:updated_at]).to be_an(String)
    end 

    it 'can create a new merchant' do 
        merchant_params = ({
                        name: 'Bob Ross'
                        created_at: 'date'
                        updated_at: 'date_2'
        })
    
     headers = {"CONTENT_TYPE" => "application/json"}

    end 
end 