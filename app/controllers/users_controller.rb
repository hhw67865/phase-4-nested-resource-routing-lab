class UsersController < ApplicationController


  rescue_from ActiveRecord::RecordNotFound, with: :no_record_error

  def show
    user = User.find(params[:id])
    render json: user, include: :items, status: :accepted
  end

  private
  def no_record_error
    render json: {error: "user not found"}, status: :not_found
  end
end
