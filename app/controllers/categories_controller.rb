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
      redirect_to categories_path, notice: "New category has been added."
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    @category.save

    redirect_to categories_path
  end

  def index
    @categories = @current_user.categories.sort_by! {|category| category[:name]}
  end
  
  private

  def category_params
    params.require(:category).permit(:name)
  end
end
