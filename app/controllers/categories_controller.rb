class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_user
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    @category.user = @current_user
    @category.save

    if @category.save
      redirect_to categories_path, notice: "New expense has been added."
    else
      render :new
    end
  end

  def index
    @categories = @current_user.categories
  end
  
  private

  def category_params
    params.require(:category).permit(:name)
  end
end
