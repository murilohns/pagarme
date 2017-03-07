json.extract! transaction, :id, :amount, :pay_method, :member_id, :boleto_url, :boleto_barcode, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
