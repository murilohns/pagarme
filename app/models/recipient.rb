class Recipient < ApplicationRecord
	has_many :transaction_recipients
	has_many :transactions, through: :transaction_recipients

end
