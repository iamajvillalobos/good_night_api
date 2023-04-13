class Api::V1::FollowsController < ApplicationController
  before_action :set_followee, only: [:create, :destroy]

  def create
    follow = Current.user.follows.new(followee: @followee)

    if follow.save
      render json: {message: "You are now following #{@followee.name}"},
        status: :created
    else
      render json: {error: follow.errors}, status: :unprocessable_entity
    end
  end

  private

  def set_followee
    @followee = User.find(params[:id])
  end
end
