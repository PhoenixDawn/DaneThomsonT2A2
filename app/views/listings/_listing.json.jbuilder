json.extract! listing, :id, :name, :price, :description, :ingredients, :user_id, :created_at, :updated_at
json.url listing_url(listing, format: :json)
