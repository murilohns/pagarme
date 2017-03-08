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

end
