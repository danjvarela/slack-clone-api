class AddSenderToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :sender, foreign_key: {to_table: :users}
  end
end
