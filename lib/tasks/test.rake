namespace :test do
  desc "TODO"
  task recipient: :environment do
    PagarMe.api_key        = 'ak_test_H3FoOSypyOOXc2fcXHpiymRWx8tnKW'
    
    recipient = PagarMe::Recipient.new(
    bank_account: {
      bank_code:       '237',
      agencia:         '1935',
      agencia_dv:      '9',
      conta:           '23398',
      conta_dv:        '9',
      legal_name:      'Fulano da Silva',
      document_number: '00000000000000' # CPF or CNPJ
    },
    transfer_enabled: false
  )

  recipient.create

  puts recipient.id
  end

  task split: :environment do
    PagarMe.api_key        = 'ak_test_H3FoOSypyOOXc2fcXHpiymRWx8tnKW'
    
    split = PagarMe::Transaction.new(
    amount:    100,      # in cents
    payment_method: "boleto" , # how to get a card hash: docs.pagar.me/capturing-card-data
    split_rule: [
      { recipient_id: "re_cj01pw7nc01n1xg6ek8udiy81", percentage: 50 },
      { recipient_id: "re_cj01px8ad01mqx66ep4ro9dpm", percentage: 50 },
    ])

    split.charge
  end

end
