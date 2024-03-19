class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip, limit: 5
      t.integer :will_split_votes
      t.integer :wont_split_votes

      t.timestamps
    end
  end
end
