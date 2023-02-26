class AddCreatorToChannels < ActiveRecord::Migration[7.0]
  def change
    add_reference :channels, :creator, foreign_key: {to_table: :users}
  end
end
