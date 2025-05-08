class Admin::ModulePropertiesController < AdminController
  before_action :set_module_property, only: [:destroy]

  def new
    @property = Property.find(params[:id])
    @production_modules = current_user.production_modules
    @module_property = ModuleProperty.new
  end

  def create
    @module_property = ModuleProperty.new(module_property_params)

    if @module_property.save
      redirect_to admin_property_path(@module_property.property), notice: "Módulo adicionado com sucesso!"
    else
      flash[:alert] = "Erro ao adicionar módulo."
      redirect_back fallback_location: admin_properties_path
    end
  end

  def destroy
    property = @module_property.property
    @module_property.destroy

    redirect_to admin_property_path(property), notice: "Módulo removido com sucesso."
  end

  private

  def set_module_property
    @module_property = ModuleProperty.find(params[:id])
  end

  def module_property_params
    params.require(:module_property).permit(:property_id, :production_module_id)
  end
end
