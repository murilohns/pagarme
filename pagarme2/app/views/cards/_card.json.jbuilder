json.extract! card, :id, :member_id, :card_hash, :created_at, :updated_at
json.url card_url(card, format: :json)
