class Api::V1::ItemsController < ApplicationController 
    def index 
        render json: ItemSerializer.new(Item.all)
    end 

    def show 
        if Item.exists?(params[:id])
            render json: ItemSerializer.new(Item.find(params[:id]))
        else 
            render status: :not_found
        end 
    end 

    def create 
        item = Item.new(item_params)
        render json: ItemSerializer.new(Item.create(item_params)), status: :created
    end 

    def update 
        item = Item.find(params[:id])
        if item.update(item_params)
            render json: ItemSerializer.new(item)
        else 
            render status :not_found
        end 
    end 

    def destroy 
        item = Item.find(params[:id])
        item.destroy
        render status: :no_content
    end 

    def find_all_items 
        items = Item.where("name ILIKE ?", "%#{params[:name]}%")
        render json: ItemSerializer.new(items)
    end 

    private 

    def item_params 
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end 
end