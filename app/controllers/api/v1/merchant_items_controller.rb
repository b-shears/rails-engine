class Api::V1::MerchantItemsController < ApplicationController
    def index 
            merchant = Merchant.find(params[:merchant_id])
            # merchant_items = Item.where("merchant_id = ?", merchant.id)
            render json: ItemSerializer.new(merchant.items)
    end 
end