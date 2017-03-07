class Transaction < ApplicationRecord
  belongs_to :member, optional: true
end
