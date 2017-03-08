class Card < ApplicationRecord
  belongs_to :member, optional: true
end
