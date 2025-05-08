class ProductionModule < ApplicationRecord
  has_many :module_properties
  belongs_to :admin

  validates :name, presence: true
  validates :settings, presence: true
  enum module_type: %i[tasks animal forestry agriculture]
end
