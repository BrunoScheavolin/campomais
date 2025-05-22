class CreateExpense
  def initialize(description:, value:, animal_production_id:)
    @description = description
    @value = value
    @animal_production = animal_production_id
  end

  def call
    return unless @description.present? && @value.present? && @animal_production.present?

    Expense.create!(
      description: @description,
      value: @value,
      animal_production_id: @animal_production
    )
  end
end
