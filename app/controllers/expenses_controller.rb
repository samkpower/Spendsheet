class ExpensesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_user
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :set_expenses, only: [:index, :dash, :monthly, :yearly, :chartkick]

  def chartkick
    @monthly_expenses = @expenses.this_month
    @yearly_expenses = @expenses.year(2013)
  end

	def index
	end

  def show
  end

  def dash
    @sorted_daily_expenses = @expenses.today.sort_by! {|expense| expense[:created_at]}
    @sorted_weekly_expenses = @expenses.this_week.sort_by! {|expense| expense[:created_at]}
    @sorted_monthly_expenses = @expenses.this_month.sort_by! {|expense| expense[:created_at]}
  end

  def monthly
    if params[:date]
      @month = params[:date][:month]
      @year = params[:date][:year]
      @date = DateTime.parse("#{year}/#{month}")
      @monthly_expenses = @expenses.month(@date)
    else
      @month = Date.today.month
      @year = Date.today.year
      @date = Date.today
      @monthly_expenses = @expenses.this_month
    end
    @sorted_monthly_expenses = @monthly_expenses.sort_by! {|expense| expense[:created_at]} 
  end

  def yearly
    if params[:date]
      year = (params[:date][:year]).to_i
      @date = DateTime.new(year)
      @yearly_expenses = @expenses.year(year)
    else
      @date = Date.today
      @yearly_expenses = @expenses.this_year
    end
    @sorted_yearly_expenses = @yearly_expenses.sort_by! {|expense| expense[:created_at]}
  end

  def new
    @expense = @current_user.expenses.build
  end

  def create
    @expense = @current_user.expenses.create(expense_params)
      unless @expense.category.user_id
        category = Category.find(@expense.category_id)
        category.user_id = @expense.user_id
        category.save
      end
    @expense.save
      if @expense.save
        redirect_to expenses_url, notice: "New expense has been added."
      else
        render :new
      end
  end

  def edit
  end

	def update
    @expense.update(expense_params)
      unless @expense.category.user_id
        category = Category.find(@expense.category_id)
        category.user_id = @expense.user_id
        category.save
      end
    @expense.save
      if @expense.save
        redirect_to expenses_url, notice: "Your entry has been updated."
      else
        render :new
      end
  end

	def destroy
    @expense.destroy
      redirect_to expenses_url
	end

	private

    def set_expense
      @expense = Expense.find(params[:id])
    end

    def set_expenses
      @expenses = @current_user.expenses
    end

    # # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:category_id, :category_name, :amount, :created_at, :updated_at)
    end
end
