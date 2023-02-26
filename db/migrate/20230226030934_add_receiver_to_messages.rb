class AddReceiverToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :receiver, polymorphic: true
  end
end
