class PeriodsController < ApplicationController
  def index
    if params[:year]
      @year = DateTime.new(params[:year].to_i)
      pry
    else
      @year = "Nope, try again"
    end
  end
end
