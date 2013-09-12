class PeriodsController < ApplicationController

  def index
    if params[:day] && params[:month] && params[:year]
      @expenses = current_user.expenses.day(params[:year], params[:month], params[:day])
    elsif params[:month] && params[:year]
      @expenses = current_user.expenses.month(params[:year], params[:month])
    else
      @expenses = current_user.expenses.year(params[:year].to_i)
    end
  end

end
