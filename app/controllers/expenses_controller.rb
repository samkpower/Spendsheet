class ExpensesController < ApplicationController
	before_filter :authenticate_user!
    before_filter :require_user
    before_action :set_expense, only: [:show, :edit, :update, :destroy]
    before_action :set_expenses, only: [:index, :dash, :daily, :monthly, :yearly]


	def index
	end

  def show
  end

  def dash
  end

  def daily
    @expenses = Expense.all
  end

  def monthly
    @expenses = Expense.all
  end

  def weekly
    @expenses = Expense.all
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
