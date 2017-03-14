class Recipient < ApplicationRecord
	has_many :split_rules
	has_many :transactions, through: :split_rules
end
