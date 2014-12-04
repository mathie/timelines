class TimelineJsonImportersController < ApplicationController
  before_filter :require_login

  def new
    @timeline_json_importer = TimelineJSONImporter.new
  end

  def create
    @timeline_json_importer = TimelineJSONImporter.new(timeline_json_importer_params.merge(user: current_user))
    if @timeline_json_importer.save
      redirect_to @timeline_json_importer.timeline, notice: 'Timeline successfully imported.'
    else
      render 'new'
    end
  end

  private

  def timeline_json_importer_params
    params.require(:timeline_json_importer).permit(:json)
  end
end