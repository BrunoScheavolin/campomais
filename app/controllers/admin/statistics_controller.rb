class Admin::StatisticsController < AdminController
  def index
    @selected_year = params[:year].presence
    period = params[:period] || "Semanal"

    @revenues = group_data(Revenue, period)
    @expenses = group_data(Expense, period)

    @current_year_revenues = Revenue.where(created_at: Date.current.beginning_of_year..Date.current.end_of_year)
      .group_by_month(:created_at, format: "%b").sum(:value)

    @selected_year_revenues = Revenue.where("extract(year from created_at) = ?", @selected_year)
      .group_by_month(:created_at, format: "%b").sum(:value)

    @current_year_expenses = Expense.where(created_at: Date.current.beginning_of_year..Date.current.end_of_year)
      .group_by_month(:created_at, format: "%b").sum(:value)

    @selected_year_expenses = Expense.where("extract(year from created_at) = ?", @selected_year)
      .group_by_month(:created_at, format: "%b").sum(:value)
  end

  private

  def group_data(model, period)
    current_year = Date.current.year

    scoped = model.where("extract(year from created_at) = ?", current_year)

    case period
    when "Mensal"
      scoped.group_by_month(:created_at, format: "%b").sum(:value)
    else
      scoped.group_by_week(:created_at, format: "%d/%m").sum(:value)
    end
  end
end
