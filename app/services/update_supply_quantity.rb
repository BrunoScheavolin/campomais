# app/services/update_supply_quantity.rb
class UpdateSupplyQuantity
  def initialize(task)
    @task = task
    @supply = Supply.find_by(id: @task.supply_id)
  end

  def call
    return unless @supply.present? && @task.supply_quantity.present?

    @supply.quantity ||= 0
    @supply.quantity -= @task.supply_quantity
    @supply.save!
  end
end
