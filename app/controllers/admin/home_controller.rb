class Admin::HomeController < AdminController
  def index
    @properties = Property.all
    @production_modules = ProductionModule.all
    @animal_productions = AnimalProduction.all
    @tasks = Task.all
    @revenues = Revenue.all
    @expenses = Expense.all
  end
end
