class Api::V1::UnfollowsController < ApplicationController
  before_action :set_followee, only: [:create, :destroy]

  def destroy
    follow = Current.user.follows.find_by(followee: @followee)

    if follow&.destroy
      render json: {message: "You have unfollowed #{@followee.name}"},
        status: :ok
    else
      render json: {error: "Follow not found"}, status: :unprocessable_entity
    end
  end

  private

  def set_followee
    @followee = User.find(params[:id])
  end
end
