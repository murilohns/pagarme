class SplitRule < ApplicationRecord
  belongs_to :transaction
  belongs_to :recipient
end
