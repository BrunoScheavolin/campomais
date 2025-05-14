class Property < ApplicationRecord
  validates :name, :address, :size, presence: true
  validates :address, presence: true
  validates :size, presence: true
  belongs_to :admin
  has_many :property_accesses
  has_many :animal_productions
end
