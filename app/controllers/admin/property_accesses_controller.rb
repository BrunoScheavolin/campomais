class Admin::PropertyAccessesController < AdminController
  before_action :set_property_access, only: [:destroy]
  before_action :set_user_by_email, only: [:create]

  def new
    @property_access = PropertyAccess.new
    @property = Property.find(params[:id])
  end

  def create
    unless @user
      return redirect_back fallback_location: admin_properties_path, alert: "Usuário com e-mail informado não encontrado."
    end

    @property_access = PropertyAccess.new(
      property_id: property_access_params[:property_id],
      user: @user
    )

    if @property_access.save
      redirect_to admin_property_path(@property_access.property), notice: "Usuário adicionado com sucesso!"
    else
      redirect_back fallback_location: admin_properties_path, alert: "Erro ao adicionar usuário."
    end
  end

  def destroy
    property = @property_access.property
    @property_access.destroy

    redirect_to admin_property_path(property), notice: "Colaborador removido com sucesso."
  end

  private

  def set_property_access
    @property_access = PropertyAccess.find(params[:id])
  end

  def set_user_by_email
    @user = User.find_by(email: property_access_params[:email])
  end

  def property_access_params
    params.require(:property_access).permit(:property_id, :email)
  end
end
