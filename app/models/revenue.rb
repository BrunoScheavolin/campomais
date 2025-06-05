class Revenue < ApplicationRecord
  belongs_to :animal_production, optional: true

  validates :description, presence: true
  validates :value, presence: true, numericality: {greater_than_or_equal_to: 0}

  scope :by_property, ->(property_id) {
    return all unless property_id.present?
    joins(:animal_production).where(animal_productions: {property_id: property_id})
  }

  scope :by_animal_production, ->(animal_production_id) {
    where(animal_production_id: animal_production_id) if animal_production_id.present?
  }

  scope :by_period, ->(period) {
    return all unless period.present?
    date = Date.strptime(period, "%Y-%m")
    where(created_at: date.beginning_of_month..date.end_of_month)
  }

  def self.search(params)
    by_property(params[:property_id])
      .by_animal_production(params[:animal_production_id])
      .by_period(params[:period])
  end
end
