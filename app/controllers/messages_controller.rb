class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[show update destroy]

  # GET /messages
  def index
    @messages = current_user.messages
    render json: @messages
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    authorize! :create, @message

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    authorize! :update, @message
    # Once a message is sent, it's receiver cannot be changed, only the body
    if @message.update(body: message_params[:body])
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    authorize! :destroy, @message
    @message.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
    authorize! :read, @message
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:receiver_id, :receiver_type, :body).merge({sender_id: current_user.id})
  end
end
