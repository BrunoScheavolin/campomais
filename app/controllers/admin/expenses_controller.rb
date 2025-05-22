class Admin::ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :set_animal_production, only: %i[new create]

  def index
    @expenses = Expense.all
  end

  def show
  end

  def new
    @expense = Expense.new
    @expense.animal_production_id = @animal_production.id if @animal_production.present?
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.animal_production_id = @animal_production.id if @animal_production.present?

    if @expense.save
      flash[:success] = "Despesa criada com sucesso!"
      redirect_to admin_animal_production_path(@expense.animal_production_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      flash[:success] = "Despesa atualizada com sucesso!"
      redirect_to admin_expenses_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
    flash[:success] = "Despesa excluída com sucesso!"
    redirect_to admin_expenses_path, status: :see_other
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def set_animal_production
    @animal_production = AnimalProduction.find_by(id: params[:animal_production_id])
  end

  def expense_params
    params.require(:expense).permit(:description, :value, :animal_production_id)
  end
end
