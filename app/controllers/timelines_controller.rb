class TimelinesController < ApplicationController
  def index
    @timelines = Timeline.all
  end

  def show
    @timeline = Timeline.find(params.require(:id))
  end

  def new
    @timeline = Timeline.new
  end

  def create
    @timeline = Timeline.new(timeline_params)
    if @timeline.save
      redirect_to @timeline, notice: "Timeline successfully created."
    else
      render 'new'
    end
  end

  def edit
    @timeline = Timeline.find(params.require(:id))
  end

  def update
    @timeline = Timeline.find(params.require(:id))
    if @timeline.update_attributes(timeline_params)
      redirect_to @timeline, notice: 'Timeline successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @timeline = Timeline.find(params.require(:id))
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
