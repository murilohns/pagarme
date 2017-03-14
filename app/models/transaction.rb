class Transaction < ApplicationRecord
  belongs_to :member, optional: true

  has_many :split_rules
  has_many :recipients, through: :split_rules

  accepts_nested_attributes_for :split_rules, reject_if: :all_blank,  allow_destroy:true
end
