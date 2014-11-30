class EventsController < ApplicationController
  def new
    @timeline = Timeline.find(params.require(:timeline_id))
    @event = @timeline.events.new
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

  private

  def event_params
    params.require(:event).permit(:started_on, :ended_on, :title, :body, :category_id)
  end
end