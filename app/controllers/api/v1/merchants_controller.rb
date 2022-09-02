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
       params[:name] && params[:name].empty? == false
       render json: MerchantSerializer.new(Merchant.find_merchant_by_name(params[:name]).first)
    end 
end 