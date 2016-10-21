class Payment < ActiveRecord::Base
  belongs_to :acts_as_bookable_booking
end