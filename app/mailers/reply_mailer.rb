class ReplyMailer < ApplicationMailer
  def new_reply_notification(comment, replied_user)
    @comment = comment
    @replied_user = user
    mail(to: @replied_user.email, subject: "あなたに返信がありました")
  end
end
