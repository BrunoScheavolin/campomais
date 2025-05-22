class Admin::AnimalProductionsController < AdminController
  before_action :set_animal_production, only: %i[show edit update destroy]
  before_action :set_production_modules, only: %i[new create edit update]
  before_action :set_property, only: %i[new create]

  def index
    @animal_productions = AnimalProduction.all
  end

  def show
  end

  def new
    @animal_production = AnimalProduction.new(property: @property)
  end

  def create
    @animal_production = AnimalProduction.new(animal_production_params)
    @animal_production.admin_id = current_admin.id

    if @animal_production.save
      flash[:success] = "Produção animal criada!"
      redirect_to edit_admin_animal_production_path(@animal_production, after_create: true)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @animal_production.update(animal_production_params)
      redirect_to admin_animal_production_path(@animal_production), notice: "Produção animal atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @animal_production.destroy
    redirect_to admin_animal_productions_path, notice: "Produção animal excluída com sucesso!"
  end

  private

  def set_animal_production
    @animal_production = AnimalProduction.find(params[:id])
  end

  def set_production_modules
    @production_modules = ProductionModule.all
  end

  def set_property
    @property = Property.find(params[:id]) if params[:id].present?
  end

  def animal_production_params
    params.require(:animal_production).permit(
      :name,
      :start_date,
      :end_date,
      :animal_quantity,
      :average_weight,
      :notes,
      :revenue,
      :initial_investment,
      :production_module_id,
      :property_id,
      :eggs_produced,
      :breed,
      :purpose,
      :milk_production,
      :used_area
    )
  end
end
