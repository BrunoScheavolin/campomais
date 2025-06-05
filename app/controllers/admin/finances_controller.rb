class Admin::FinancesController < ApplicationController
  def index
    @properties = Property.all
    @animal_productions = AnimalProduction.all
    @transactions = []

    if params[:transaction_type].blank? || params[:transaction_type] == "revenues"
      revenues = Revenue.search(params)
      revenues = revenues.where("created_at >= ?", params[:start_date]) if params[:start_date].present?
      @transactions += revenues.map { |r| r.attributes.merge("type" => "Receita", "record" => r) }
    end

    if params[:transaction_type].blank? || params[:transaction_type] == "expenses"
      expenses = Expense.search(params)
      expenses = expenses.where("created_at >= ?", params[:start_date]) if params[:start_date].present?
      @transactions += expenses.map { |e| e.attributes.merge("type" => "Despesa", "record" => e) }
    end

    @transactions.sort_by! { |t| t["created_at"] }.reverse!
  end
end
