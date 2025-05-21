class Task < ApplicationRecord
  belongs_to :animal_production
  has_one_attached :image
  belongs_to :supply, optional: true
end
