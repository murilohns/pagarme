json.extract! address, :id, :street, :neighborhood, :zipcode, :street_number, :complementary, :ddd, :phone_number, :member_id, :created_at, :updated_at
json.url address_url(address, format: :json)
