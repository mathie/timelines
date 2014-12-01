class EventsController < ApplicationController
  def show
    @event = Event.find(params.require(:id))
  end

  def new
    @timeline = Timeline.find(params.require(:timeline_id))
    @event = @timeline.events.new
    @categories = @timeline.categories
  end

  def create
    @timeline = Timeline.find(params.require(:timeline_id))
    @event = @timeline.events.build(event_params)
    if @event.save
      redirect_to @event, notice: 'Event successfully created.'
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find(params.require(:id))
    @timeline = @event.timeline
    @categories = @timeline.categories
  end

  def update
    @event = Event.find(params.require(:id))
    if @event.update_attributes(event_params)
      redirect_to @event, notice: 'Event successfully updated.'
    else
      render 'edit'
    end
  end

  private

  def event_params
    params.require(:event).permit(:started_on, :ended_on, :title, :body, :category_id)
  end
end