json.extract! recipient, :id, :bank_code, :agencia, :agencia_dv, :conta, :conta_dv, :legal_name, :document_number, :transfer_enabled, :created_at, :updated_at
json.url recipient_url(recipient, format: :json)
