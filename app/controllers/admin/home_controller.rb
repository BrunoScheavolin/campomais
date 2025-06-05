class Admin::HomeController < AdminController
  def index
    @properties = Property.all
    @production_modules = ProductionModule.all
    @animal_productions = AnimalProduction.all
    @tasks = Task.all

    start_of_week = Time.current.beginning_of_week
    end_of_week = Time.current.end_of_week

    @weekly_revenues = Revenue.where(created_at: start_of_week..end_of_week).sum(:value)
    @weekly_expenses = Expense.where(created_at: start_of_week..end_of_week).sum(:value)
  end
end
