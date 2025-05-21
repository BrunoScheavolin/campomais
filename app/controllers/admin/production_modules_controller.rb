class Admin::ProductionModulesController < ApplicationController
  before_action :set_production_module, only: %i[show edit update destroy]

  def index
    @production_modules = ProductionModule.all
  end

  def show
  end

  def new
    @production_module = ProductionModule.new(module_type: params[:type])
  end

  def create
    @production_module = ProductionModule.new(production_module_params)
    @production_module.admin_id = current_admin.id
    @production_module.active = true

    if @production_module.save
      flash[:success] = "Módulo criado!"
      redirect_to admin_production_modules_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @production_module.settings = extract_settings(params[:settings]) if params[:settings]
    @production_module.production_settings = extract_production_settings(params[:production_settings]) if params[:production_settings]

    if @production_module.update(production_module_params)
      redirect_to new_admin_production_module_path(@production_module), notice: "Módulo atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @production_module.destroy
    redirect_to new_admin_production_module_path, notice: "Módulo excluído com sucesso."
  end

  private

  def set_production_module
    @production_module = ProductionModule.find(params[:id])
  end

  def production_module_params
    base = params.require(:production_module).permit(
      :name, :active, :module_type,
      :description, :due_date, :priority, :uses_supplies, :observation,
      :task_type, :responsible,
      :breed, :animal_quantity, :average_weight, :eggs_produced,
      :milk_production, :used_area, :notes
    )

    base[:settings] = extract_settings(base.slice(
      :description, :due_date, :priority, :uses_supplies,
      :task_type, :responsible, :observation
    ))

    base[:production_settings] = extract_production_settings(base.slice(
      :breed, :animal_quantity, :average_weight, :eggs_produced,
      :milk_production, :used_area, :notes
    ))

    base.except(
      :description, :due_date, :priority, :uses_supplies,
      :task_type, :responsible, :observation,
      :breed, :animal_quantity, :average_weight, :eggs_produced,
      :milk_production, :used_area, :notes
    )
  end

  def extract_settings(fields)
    fields.to_h.slice(
      "description", "due_date", "priority", "uses_supplies",
      "observation", "task_type", "responsible"
    )
  end

  def extract_production_settings(fields)
    fields.to_h.slice(
      "breed", "animal_quantity", "average_weight", "eggs_produced",
      "milk_production", "used_area", "notes"
    )
  end
end
