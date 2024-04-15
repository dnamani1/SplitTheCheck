class RemoveSplitVotesFromRestaurants < ActiveRecord::Migration[7.0]
  def change
    remove_column :restaurants, :will_split_votes, :integer
    remove_column :restaurants, :wont_split_votes, :integer
  end
end
