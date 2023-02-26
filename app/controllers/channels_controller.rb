class ChannelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel, only: %i[show update destroy add_members]

  # GET /channels
  def index
    @channels = current_user.created_channels
    render json: @channels
  end

  # GET /channels/1
  def show
    render json: @channel
  end

  # POST /channels
  def create
    authorize! :create, Channel
    @channel = Channel.new(channel_params)
    @channel.creator = current_user

    if @channel.save
      render json: @channel, status: :created, location: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /channels/1
  def update
    authorize! :update, @channel
    if @channel.update(channel_params)
      render json: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /channels/1
  def destroy
    authorize! :destroy, @channel
    @channel.destroy
  end

  def add_members
    params[:member_ids].each do |id|
      user = User.find(id)
      @channel.members << user
    end
  rescue ActiveRecord::RecordInvalid
    render json: @channel.errors, status: :unprocessable_entity
  else
    render json: @channel
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
    authorize! :read, @channel
  end

  # Only allow a list of trusted parameters through.
  def channel_params
    params.require(:channel).permit(:name, :member_ids)
  end
end
