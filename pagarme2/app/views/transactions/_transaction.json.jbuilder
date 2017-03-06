json.extract! transaction, :id, :amount, :payment_method, :recipient_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
