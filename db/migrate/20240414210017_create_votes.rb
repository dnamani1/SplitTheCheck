class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.boolean :split

      t.timestamps
    end
    add_index :votes, [:user_id, :restaurant_id], unique: true
  end
end
