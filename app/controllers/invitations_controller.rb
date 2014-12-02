class InvitationsController < ApplicationController
  before_filter :require_login

  def new
    @timeline = current_user.timelines.find(params.require(:timeline_id))
    @invitation = @timeline.invitations.new
  end

  def create
    @timeline = current_user.timelines.find(params.require(:timeline_id))
    @invitation = @timeline.invitations.new(invitation_params)
    if @invitation.save
      InvitationMailer.invitation_email(@invitation).deliver
      redirect_to @timeline, notice: 'Invitation sent.'
    else
      render 'new'
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email_address)
  end
end