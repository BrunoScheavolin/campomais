class TasksController < ApplicationController
  before_action :set_task, only: %i[edit show update destroy]

  def new
    @task = Task.new
    @animal_production = AnimalProduction.find(params[:id])
    @task_settings = @animal_production.production_module&.settings || {}
    @supplies = Supply.all
  end

  def show
    @supply = Supply.find_by(id: @task.supply_id)
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      CreateExpense.new(
        description: @task.description,
        value: @task.expense,
        animal_production_id: @task.animal_production_id
      ).call

      UpdateSupplyQuantity.new(@task).call
      flash[:success] = "Tarefa criada!"
      redirect_to admin_animal_production_path(@task.animal_production_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = "Insumo adicionado!"
      redirect_to task_path(@task)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @animal_production_id = @task.animal_production_id
    @task.destroy
    redirect_to admin_animal_production_path(@animal_production_id), notice: "Tarefa excluída com sucesso."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(
      :description,
      :due_date,
      :priority,
      :supply_id,
      :supply_quantity,
      :expense,
      :observation,
      :task_type,
      :animal_production_id,
      :responsible,
      :image
    )
  end
end
