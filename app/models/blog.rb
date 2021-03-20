class Blog < ApplicationRecord
  belongs_to :user
  belongs_to :payment

  scope :with_payment, -> { where(:payments)}
  

end
