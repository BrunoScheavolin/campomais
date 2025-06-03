class Admin::FinancesController < ApplicationController
  def index
    @revenues = Revenue.all
    @expenses = Expense.all
  end
end
