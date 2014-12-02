class CollaborationsController < ApplicationController
  before_filter :require_login

  def new
    @invitation = Invitation.find(params.require(:invitation_id))
    @timeline = @invitation.timeline
    @collaboration = @timeline.collaborations.new
  end

  def create
    @invitation = Invitation.find(params.require(:invitation_id))
    @timeline = @invitation.timeline
    @collaboration = @timeline.collaborations.new(user: current_user)
    if @collaboration.save
      redirect_to @timeline, notice: 'You are now collaborating on this timeline.'
    else
      render 'new'
    end
  end
end