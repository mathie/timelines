class InvitationMailer < ApplicationMailer
  def invitation_email(invitation)
    @url = new_invitation_collaboration_url(invitation)
    @timeline = invitation.timeline

    mail(to: invitation.email_address, subject: 'Invitation to collaborate on a timeline')
  end
end
