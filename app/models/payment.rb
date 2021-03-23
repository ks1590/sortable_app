class Payment < ApplicationRecord
  has_many :blogs, dependent: :destroy
end
