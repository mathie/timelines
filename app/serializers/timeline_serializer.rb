class TimelineSerializer
  def initialize(timeline)
    @timeline = timeline
  end

  def as_json(options = {})
    {
      timeline: timeline
    }
  end

  def timeline
    {
      headline: @timeline.title,
      type: 'default',
      text: @timeline.body,
      date: events,
      era: eras
    }
  end

  def events
    @timeline.events.map do |event|
      {
        startDate: event.started_on.strftime("%Y,%m,%d"),
        endDate: event.ended_on.strftime("%Y,%m,%d"),
        headline: event.title,
        text: event.body,
        tag: event.category.title
      }
    end
  end

  def eras
    @timeline.eras.map do |era|
      {
        startDate: era.started_on.strftime("%Y,%m,%d"),
        endDate: era.ended_on.strftime("%Y,%m,%d"),
        headline: era.title,
        text: era.body
      }
    end
  end
end