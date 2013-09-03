class ExpensesController < ApplicationController
	before_filter :authenticate_user!
    before_filter :require_user
    before_action :set_expense, only: [:show, :edit, :update, :destroy]
    before_action :set_expenses, only: [:index, :dash, :daily, :weekly, :monthly, :yearly, :chartkick]

  def chartkick
    @monthly_expenses = @expenses.this_month
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

  def daily
    daily_expenses = @expenses.today
    @sorted_daily_expenses = daily_expenses.sort_by! {|expense| expense[:created_at]}
  end

  def weekly
    weekly_expenses = @expenses.this_week
    @sorted_weekly_expenses = weekly_expenses.sort_by! {|expense| expense[:created_at]}
  end

  def monthly
    monthly_expenses = @expenses.this_month
    @sorted_monthly_expenses = monthly_expenses.sort_by! {|expense| expense[:created_at]}
  end

  def yearly
    yearly_expenses = @expenses.year(2013)
    @sorted_yearly_expenses = yearly_expenses.sort_by! {|expense| expense[:created_at]}
  end

  def new
    @expense = @user.expenses.build
  end

  def create
    @expense = @user.expenses.create(expense_params)
    
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

    def require_user
      @user = current_user
    end
    # Use callbacks to share common setup or constraints between actions.

    def set_expense
      @expense = Expense.find(params[:id])
    end

    def set_expenses
      @expenses = Expense.all
    end

    # # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:category, :amount, :created_at, :updated_at)
    end
end
