class Chart < ApplicationRecord
  belongs_to :user
  has_many :datasets, dependent: :destroy
  mount_uploader :chart_image, PhotoUploader
end
