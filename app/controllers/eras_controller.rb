class ErasController < ApplicationController
  before_filter :require_login

  def index
    @timeline = current_user.timelines.find(params.require(:timeline_id))
  end

  def new
    @timeline = current_user.timelines.find(params.require(:timeline_id))
    @era = @timeline.eras.new
  end

  def create
    @timeline = current_user.timelines.find(params.require(:timeline_id))
    @era = @timeline.eras.build(era_params)
    if @era.save
      redirect_to timeline_eras_path(@timeline), notice: 'Era successfully created'
    else
      render 'new'
    end
  end

  def edit
    @era = Era.find(params.require(:id))
  end

  def update
    @era = Era.find(params.require(:id))
    if @era.update_attributes(era_params)
      redirect_to timeline_eras_path(@era.timeline), notice: 'Era successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @era = Era.find(params.require(:id))
    if @era.destroy
      redirect_to timeline_eras_path(@era.timeline), notice: 'Era deleted'
    else
      redirect_to timeline_eras_path(@era.timeline), alert: 'Era cannot be deleted'
    end
  end

  private

  def era_params
    params.require(:era).permit(:started_on, :ended_on, :title, :body)
  end
end