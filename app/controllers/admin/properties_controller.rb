class Admin::PropertiesController < AdminController
  before_action :set_property, only: %i[show edit update destroy]

  def index
    @properties = Property.all
  end

  def show
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    @property.admin_id = current_admin.id
    if @property.save
      redirect_to admin_property_path(@property), notice: "Property created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @property.update(property_params)
      redirect_to admin_property_path(@property), notice: "Property updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    redirect_to admin_properties_path, notice: "Property deleted successfully!"
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:name, :address, :size)
  end
end
