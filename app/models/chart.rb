class Chart < ApplicationRecord
  belongs_to :user
  has_many :datasets, dependent: :destroy
end
