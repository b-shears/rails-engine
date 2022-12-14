require 'rails_helper'

describe "Items API" do
  it "sends a list of all items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)

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

  it 'can get one item by its id' do 
    merchant = create(:merchant)
    item_id = create(:item, merchant_id: merchant.id).id

    get "/api/v1/items/#{item_id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(response.status).to_not eq(404)
    
    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
    
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end 

   it 'returns a 404 response if an invalid id is entered for one item' do 
       merchant = create(:merchant)
       item_id = create(:item, merchant_id: merchant.id).id

        get "/api/v1/items/123456789"

        expect(response.status).to eq(404)
    end 

  it 'can create a new item' do 
    merchant = create(:merchant)
    
    item_params = ({ 
                    name: "Duff",
                    description: "Light Beer",
                    unit_price: 2.5,
                    merchant_id: merchant.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(response.status).to eq(201)
     
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
    
  end 

  it 'can update an item' do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id

    previous_name = Item.last.name
    item_params = { name: 'Duff Beer'}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item: item_params)
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Duff Beer")
  end

  it 'can destroy an item' do 
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end 

  it 'can return all items by name' do 
    merchant_1 = create(:merchant, name: "M-M-M-M Mud")
    item_1 = create(:item, name: "Spade Shovel", merchant_id: merchant_1.id)
    item_2 = create(:item, name: "Flat Shovel", merchant_id: merchant_1.id)

    get "/api/v1/items/find_all/?name=shovel"

    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(2)
    
    items[:data].each do |item| 
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

  it 'can find all items by fragment' do 
    merchant_1 = create(:merchant, name: "M-M-M-M Mud")
    item_1 = create(:item, name: "Spade Shovel", merchant_id: merchant_1.id)
    item_2 = create(:item, name: "Flat Shovel", merchant_id: merchant_1.id)

    get "/api/v1/items/find_all?name=spa"

    expect(response).to be_successful 

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(1)

    items[:data].each do |item| 
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to eq("Spade Shovel")
    end
  end 

  it 'can find an item that is greater than or equal to the min_price that is input' do 
    merchant_1 = create(:merchant, name: "M-M-M-M Mud")
    item_1 = create(:item, name: "Spade Shovel", merchant_id: merchant_1.id, unit_price: 95)
    item_2 = create(:item, name: "Flat Shovel", merchant_id: merchant_1.id, unit_price: 80)

    get "/api/v1/items/find_all?min_price=90"

    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)
  
    expect(items[:data].count).to eq(1)
    expect(items[:data].first[:id]).to eq("#{item_1.id}")
  end 

  it 'can find an item that is less than or equal to the max_price that is input' do 
    merchant_1 = create(:merchant, name: "M-M-M-M Mud")
    item_1 = create(:item, name: "Spade Shovel", merchant_id: merchant_1.id, unit_price: 95)
    item_2 = create(:item, name: "Flat Shovel", merchant_id: merchant_1.id, unit_price: 80)
    item_3 = create(:item, name: "Trench Shovel", merchant_id: merchant_1.id, unit_price: 100)

    get "/api/v1/items/find_all?max_price=95"

    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)
    
    expect(items[:data].count).to eq(2)
    expect(items[:data].first[:id]).to eq("#{item_1.id}")
    expect(items[:data].last[:id]).to eq("#{item_2.id}")
  end 
end