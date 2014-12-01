class TimelinesController < ApplicationController
  before_filter :require_login

  def index
    @timelines = current_user.timelines
  end

  def show
    @timeline = current_user.timelines.find(params.require(:id))
    respond_to do |format|
      format.html {}
      format.json { render json: TimelineSerializer.new(@timeline) }
    end
  end

  def new
    @timeline = current_user.timelines.new
  end

  def create
    @timeline = current_user.timelines.new(timeline_params)
    if @timeline.save
      redirect_to @timeline, notice: "Timeline successfully created."
    else
      render 'new'
    end
  end

  def edit
    @timeline = current_user.timelines.find(params.require(:id))
  end

  def update
    @timeline = current_user.timelines.find(params.require(:id))
    if @timeline.update_attributes(timeline_params)
      redirect_to @timeline, notice: 'Timeline successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @timeline = current_user.timelines.find(params.require(:id))
    if @timeline.destroy
      redirect_to timelines_path, notice: 'Timeline successfully deleted.'
    else
      redirect_to @timeline, alert: 'Timeline could not be deleted.'
    end
  end

  private

  def timeline_params
    params.require(:timeline).permit(:title, :body)
  end
end
