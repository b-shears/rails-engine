class Item < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true
    validates :unit_price, presence: true
    belongs_to :merchant
    has_many :invoice_items, dependent: :destroy
    has_many :invoices, through: :invoice_items

    def self.find_items_by_name(name)
        where("name ILIKE ?", "%#{name}%")
    end 

    def self.find_all_by_min_price(min_price)
        where("unit_price >= ?", min_price)
    end 

    def self.find_all_by_max_price(max_price)
       where("unit_price <= ?", max_price)
    end 
end

