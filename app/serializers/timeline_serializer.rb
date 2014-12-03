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
      text: markdown(@timeline.body),
      date: events,
      era: eras
    }.tap do |timeline|
      if @timeline.cover_image.present?
        timeline[:asset] = {
          media: @timeline.cover_image.url,
          caption: @timeline.cover_image_caption,
          credit: @timeline.cover_image_credit
        }
      end
    end
  end

  def events
    @timeline.events.order(:started_on, 'ended_on DESC').map do |event|
      {
        startDate: event.started_on.strftime("%Y,%m,%d"),
        headline: event.title,
        text: markdown(event.body),
        tag: event.category.title
      }.tap do |event_json|
        if event.ended_on.present?
          event_json[:endDate] = event.ended_on.strftime("%Y,%m,%d")
        end

        if event.image.present?
          event_json[:asset] = {
            media: event.image.url,
            caption: event.image_caption,
            credit: event.image_credit,
            thumbnail: event.image.thumb.url
          }
        end
      end
    end
  end

  def eras
    @timeline.eras.map do |era|
      {
        startDate: era.started_on.strftime("%Y,%m,%d"),
        endDate: era.ended_on.strftime("%Y,%m,%d"),
        headline: era.title,
        text: markdown(era.body)
      }
    end
  end

  def markdown(text)
    @markdown ||= Redcarpet::Markdown.new(renderer, no_intra_emphasis: true, tables: true, autolink: true)

    @markdown.render(text)
  end

  def renderer
    @renderer ||= Redcarpet::Render::HTML.new(filter_html: true, no_styles: true, safe_links_only: true)
  end
end