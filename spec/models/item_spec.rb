require 'rails_helper'

RSpec.describe Item, type: :model do
    describe 'validations' do
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:description) }
        it { should validate_presence_of(:unit_price) }
    end

    describe 'relationships' do
        it { should belong_to :merchant }
        it { should have_many :invoice_items }
        it { should have_many(:invoices).through(:invoice_items) }
    end

  before :each do 
    @merchant_1 = create(:merchant, name: "Mud") 
    @item_1 = create(:item, name: "Spade Shovel", unit_price: 10.99, merchant_id: @merchant_1.id)
    @item_2 = create(:item, name: "Flat Shovel", unit_price: 8.99, merchant_id: @merchant_1.id)
    @item_3 = create(:item, name: "Plants", unit_price: 20.00, merchant_id: @merchant_1.id)
  end 

  describe 'class methods' do 
    describe 'find_items_by_name' do 
        it 'finds all items that match the name input' do 
            input = 'shovel'
            expect(Item.find_items_by_name(input)).to eq([@item_1, @item_2])
        end 
    end 

    describe 'find_items_by_min_price' do 
        it 'can return items that are equal to or greater than a minimum price' do 
            input = 15.00
            expect(Item.find_all_by_min_price(input)).to eq([@item_3])
        end 
    end 

    describe 'find_items_by_max_price' do 
        it 'can return all items that are less than or equal to a maximum price' do 
            input = 25.00
            expect(Item.find_all_by_max_price(input)).to eq([@item_1, @item_2, @item_3])
        end 
    end 
  end 
end
