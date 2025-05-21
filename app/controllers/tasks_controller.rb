class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy]

  def new
    @task = Task.new
    @animal_production = AnimalProduction.find(params[:id])
    @task_settings = @animal_production.production_module&.settings || {}
    @supplies = Supply.all
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      UpdateAnimalProductionExpenses.new(@task).call
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
    @task.destroy
    redirect_to @animal_production, notice: "Tarefa excluída com sucesso."
  end

  private

  def set_task
    @task = @animal_production.tasks.find(params[:id])
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
      :responsible
    )
  end
end
