class Api::V1::SearchesController < ApplicationController

    def find_merchant
       merchant = Merchant.where("name ILIKE ?", "%#{params[:name]}%").first
    #    if merchant.nil?
    #         render json: {data: { message: {"No merchant found"} } }
    #    else 
            render json: MerchantSerializer.new(merchant)
    #    end 
    end 

    def find_all_items 
        items = Item.where("name ILIKE ?", "%#{params[:name]}%")
        render json: ItemSerializer.new(items)
    end 

    def item 
        # binding.pry
    end 
end 