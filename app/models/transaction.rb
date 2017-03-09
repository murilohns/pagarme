class Transaction < ApplicationRecord
  belongs_to :member, optional: true
  has_many :recipients
end
