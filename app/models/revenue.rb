class Revenue < ApplicationRecord
  belongs_to :animal_production, optional: true

  validates :description, presence: true
  validates :value, presence: true, numericality: {greater_than_or_equal_to: 0}
end
