class ChangeZipToStringInRestaurants < ActiveRecord::Migration[7.0]
  def change
    change_column :restaurants, :zip, :string, limit: 5
  end
end
