class PeriodsController < ApplicationController
  def index
    @expenses = current_user.expenses.year(params[:year].to_i)
  end
end
