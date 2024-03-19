json.extract! restaurant, :id, :name, :address, :city, :state, :zip, :will_split_votes, :wont_split_votes, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
