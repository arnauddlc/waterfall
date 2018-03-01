class Dataset < ApplicationRecord
  belongs_to :chart

  validates :value, presence: true
end
