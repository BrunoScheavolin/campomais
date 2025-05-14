class AnimalProduction < ApplicationRecord
  belongs_to :admin
  belongs_to :property
  belongs_to :production_module

  validates :name, :start_date, :end_date, presence: true
end
