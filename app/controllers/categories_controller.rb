class CategoriesController < ApplicationController
  before_filter :require_login

  def index
    @timeline = current_user.timelines.find(params.require(:timeline_id))
  end

  def show
    @category = Category.find(params.require(:id))
    @timeline = @category.timeline
  end

  def new
    @timeline = current_user.timelines.find(params.require(:timeline_id))
    @category = @timeline.categories.new
  end

  def create
    @timeline = current_user.timelines.find(params.require(:timeline_id))
    @category = @timeline.categories.build(category_params)
    if @category.save
      redirect_to @category, notice: 'Category created'
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params.require(:id))
  end

  def update
    @category = Category.find(params.require(:id))
    if @category.update_attributes(category_params)
      redirect_to @category, notice: 'Category updated'
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params.require(:id))
    if @category.destroy
      redirect_to timeline_categories_path(@category.timeline), notice: 'Category deleted'
    else
      redirect_to @category, alert: 'Category cannot be deleted'
    end
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end