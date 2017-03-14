class SplitRule < ApplicationRecord
  belongs_to :owner, foreign_key: "transaction_id", class_name: "Transaction", optional: true
  belongs_to :recipient

  accepts_nested_attributes_for :recipient, reject_if: :all_blank,  allow_destroy:true
end
