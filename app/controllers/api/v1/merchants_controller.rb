class Api::V1::MerchantsController < ApplicationController
    def index 
        render json: MerchantSerializer.new(Merchant.all)
    end 

    def show 
       if Merchant.exists?(params[:id])
         render json: MerchantSerializer.new(Merchant.find(params[:id]))
       else 
         render status: :not_found
       end 
    end 

    def find_merchant
       merchant = Merchant.where("name ILIKE ?", "%#{params[:name]}%").first
       render json: MerchantSerializer.new(merchant)
    #    if merchant.nil?
    #         render json: {data: { message: {"No merchant found"} } }
    #    else 
      
    #    end 
    end 

end 