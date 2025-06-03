class Admin::RevenuesController < ApplicationController
  before_action :set_revenue, only: %i[show edit update destroy]
  before_action :set_animal_production, only: %i[new create]

  def index
    @revenues = Revenue.all
  end

  def show
  end

  def new
    @revenue = Revenue.new
    @revenue.animal_production_id = @animal_production.id if @animal_production.present?
  end

  def edit
  end

  def create
    @revenue = Revenue.new(revenue_params)
    @revenue.animal_production_id = @animal_production.id if @animal_production.present?

    if @revenue.save
      flash[:success] = "Receita adicionada com sucesso!"
      redirect_to admin_animal_production_path(@revenue.animal_production_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @revenue.update(revenue_params)
      flash[:success] = "Receita atualizada com sucesso!"
      redirect_to admin_revenues_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @revenue.destroy
    flash[:success] = "Receita excluída com sucesso!"
    redirect_to admin_revenues_path, status: :see_other
  end

  private

  def set_revenue
    @revenue = Revenue.find(params[:id])
  end

  def set_animal_production
    @animal_production = AnimalProduction.find_by(id: params[:animal_production_id])
  end

  def revenue_params
    params.require(:revenue).permit(:description, :value, :animal_production_id)
  end
end
