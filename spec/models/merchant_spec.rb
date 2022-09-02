require 'rails_helper'

RSpec.describe Merchant, type: :model do

    describe 'relationships' do 
        it { should have_many :items }
    end 

    before :each do 
        @merchant_1 = create(:merchant, name: "My") 
        @merchant_2 = create(:merchant, name: "Name")
        @merchant_3 = create(:merchant, name: "Is")
        @merchant_4 = create(:merchant, name: "Mud")
    end 

    describe 'class methods' do 
        describe 'find_merchant_by_name' do 
            it 'can find a merchant by name' do 
                input = "Mud"
                expect(Merchant.find_merchant_by_name(input)).to eq([@merchant_4])
            end 
        end 
    end 
end
