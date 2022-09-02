class Merchant < ApplicationRecord
    has_many :items

    def self.find_merchant_by_name(name)
        where("name ILIKE ?", "%#{name}%")
    end 
end
