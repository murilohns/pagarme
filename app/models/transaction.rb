class Transaction < ApplicationRecord
  belongs_to :member, optional: true

  has_many :transaction_recipients
  has_many :recipients, through: :transaction_recipients

  accepts_nested_attributes_for :recipients, allow_destroy:true
end
