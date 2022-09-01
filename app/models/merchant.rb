class Merchant < ApplicationRecord
    has_many :items

    # def merchant_name_query
    #   merchant = Merchant.where("name ILIKE ?", "%#{params[:name]}")
    # end 
end
