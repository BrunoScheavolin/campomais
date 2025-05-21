class ProductionModule < ApplicationRecord
  belongs_to :admin

  validates :name, presence: true
  validates :settings, presence: true
  enum module_type: %i[animal forestry agriculture]
  has_many :animal_productions
end
