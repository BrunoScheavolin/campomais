class AnimalProduction < ApplicationRecord
  belongs_to :admin
  belongs_to :property
  belongs_to :production_module

  has_many :tasks
  has_many :supplies
  has_many :expenses
end
