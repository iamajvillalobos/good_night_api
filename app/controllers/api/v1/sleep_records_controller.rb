class Api::V1::SleepRecordsController < ApplicationController
  def create
    render json: {message: "You are clocked in"}, status: :created
  end

  def update
    render json: {message: "You are clocked out"}, status: :ok
  end
end
