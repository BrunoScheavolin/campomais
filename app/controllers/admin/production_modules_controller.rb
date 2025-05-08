class Admin::ProductionModulesController < ApplicationController
  before_action :set_module, only: %i[show edit update destroy]

  def index
    @production_modules = ProductionModule.all
  end

  def show
  end

  def new
    @production_module = ProductionModule.new
    @production_module.module_type = params[:type]
  end

  def create
    @production_module = ProductionModule.new(production_module_params)
    @production_module.admin_id = current_admin.id
    @production_module.active = true
    if @production_module.save
      redirect_to admin_production_modules_path, notice: "Module was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @production_module.settings = build_settings_json(params[:settings]) if params[:settings]

    if @production_module.update(production_module_params)
      redirect_to new_admin_production_module_path(@production_module), notice: "Module was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @production_module.destroy
    redirect_to new_admin_production_module_path, notice: "Module was successfully deleted."
  end

  private

  def set_module
    @production_module = ProductionModule.find(params[:id])
  end

  def production_module_params
    params.require(:production_module).permit(
      :name, :active, :property_id, :module_type,
      :description, :due_date, :priority, :expense
    ).tap do |whitelisted|
      whitelisted[:settings] = {
        description: whitelisted.delete(:description),
        due_date: whitelisted.delete(:due_date),
        priority: whitelisted.delete(:priority),
        expense: whitelisted.delete(:expense)
      }
    end
  end

  def build_settings_json(fields)
    fields.permit(:description, :due_date, :priority, :expense).to_h
  end
end
