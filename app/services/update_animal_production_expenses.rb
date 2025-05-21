# app/services/update_animal_production_expenses.rb
class UpdateAnimalProductionExpenses
  def initialize(supply)
    @supply = supply
    @animal_production = supply.animal_production
  end

  def call
    return unless @animal_production.present? && @supply.expense.present?

    @animal_production.expenses ||= 0
    @animal_production.expenses += @supply.expense
    @animal_production.save!
  end
end
