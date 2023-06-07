class TeaTypeSubscription < ApplicationRecord
  belongs_to :subscription
  belongs_to :tea_type
end
