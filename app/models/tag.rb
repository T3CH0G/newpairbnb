class Tag < ActiveRecord::Base
	has_many :taggings
	has_many :listings, through: :taggings
end
