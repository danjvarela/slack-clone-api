class ChannelsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /channels
  def index
    render json: @channels
  end

  # GET /channels/1
  def show
    render json: @channel
  end

  # POST /channels
  def create
    @channel.creator = current_user

    if @channel.save
      render json: @channel, status: :created, location: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /channels/1
  def update
    if @channel.update(channel_params)
      render json: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /channels/1
  def destroy
    @channel.destroy
  end

  private

  # Only allow a list of trusted parameters through.
  def channel_params
    params.require(:channel).permit(:name, :creator_id)
  end
end
