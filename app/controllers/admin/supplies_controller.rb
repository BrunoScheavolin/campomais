class Admin::SuppliesController < ApplicationController
  before_action :set_supply, only: %i[show edit update destroy]
  before_action :set_animal_production, only: %i[new create]

  def index
    @supplies = Supply.all
  end

  def show
  end

  def new
    @supply = Supply.new
    @supply.animal_production_id = @animal_production.id if @animal_production.present?
  end

  def edit
  end

  def create
    @supply = Supply.new(supply_params)
    @supply.expense = @supply.quantity * @supply.expense
    @supply.animal_production_id = @animal_production.id if @animal_production.present?

    if @supply.save
      UpdateAnimalProductionExpenses.new(@supply).call
      flash[:success] = "Insumo adicionado!"
      redirect_to admin_animal_production_path(@supply.animal_production_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @supply.update(supply_params)
      redirect_to admin_supplies_path, notice: "Insumo atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @supply.destroy
    redirect_to admin_supplies_path, notice: "Insumo excluído com sucesso!", status: :see_other
  end

  private

  def set_supply
    @supply = Supply.find(params[:id])
  end

  def set_animal_production
    @animal_production = AnimalProduction.find_by(id: params[:id])
  end

  def supply_params
    params.require(:supply).permit(:name, :quantity, :expense, :animal_production_id)
  end
end
