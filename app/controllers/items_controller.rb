class ItemsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :no_record_error

  def index
    if params[:user_id]
      render json: User.find(params[:user_id]).items, status: :accepted
    else
      items = Item.all
      render json: items, include: :user, status: :accepted
    end
  end

  def show
    if params[:user_id]
      render json: User.find(params[:user_id]).items.find(params[:id]), status: :accepted
    else
      items = Item.find(params[:id])
      render json: items, include: :user, status: :accepted
    end
  end

  def create
    if params[:user_id]
      render json: User.find(params[:user_id]).items.create!(item_params), include: :user, status: :created
    else
      
      render json: Item.create!(item_params), include: :user, status: :created
    end
  end


  private
  def item_params
    params.permit(:name,:description,:price)
  end

  def no_record_error
    render json: {error: "item not found"}, status: :not_found
  end
end
