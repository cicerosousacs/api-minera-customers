class Customer < ApplicationRecord
  belongs_to :status
  belongs_to :subscription
end
