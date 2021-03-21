class Blog < ApplicationRecord
  belongs_to :user
  belongs_to :payment
  belongs_to :category

  scope :with_payment, -> { where(:payments)}
  

end
