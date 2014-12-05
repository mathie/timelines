class TimelineJSONImporter
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :timeline

  def persisted?
    timeline.present? && timeline.persisted?
  end

  def initialize(attributes = {})
    @user = attributes[:user]
    @json = attributes[:json]
  end

  def save
    parsed = JSON.parse(@json.read)

    timeline_json = parsed['timeline']
    @timeline = @user.timelines.build(
      title:               timeline_json['headline'],
      body:                timeline_json['text'],
      cover_image:         timeline_json['asset']['media'],
      cover_image_caption: timeline_json['asset']['caption'],
      cover_image_credit:  timeline_json['asset']['credit']
    )
    if @timeline.save
      @timeline.users << @user
      timeline_json['date'].each do |date|
        category = @timeline.categories.where(title: date['tag']).take
        unless category.present?
          category = @timeline.categories.create!(title: date['tag'])
        end

        @timeline.events.create!(
          started_on: parse_date(date['startDate']),
          ended_on:   parse_date(date['endDate']),
          title:      date['headline'],
          body:       date['text'],
          category:   category
        )
      end
      timeline_json['era'].each do |era|
        @timeline.eras.create!(
          started_on: parse_date(era['startDate']),
          ended_on:   parse_date(era['endDate']),
          title:      era['headline'],
          body:       era['text'],
        )
      end
    end
  end

  private

  def parse_date(value)
    Date.strptime(value,'%Y,%m,%d') if value.present?
  end
end