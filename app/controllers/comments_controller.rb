class CommentsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_comment, only: :destroy

  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      notify_subscribers(@event, @new_comment)

      redirect_to @event, notice: I18n.t('helpers.controllers.comments.created')
    else
      flash.now[:alert] = @new_comment.errors.full_messages
      render 'events/show', alert: I18n.t('helpers.controllers.comments.error')
    end
  end

  def destroy
    message = {notice: I18n.t('helpers.controllers.comments.destroyed')}

    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = {alert: I18n.t('controllers.comments.error')}
    end

    redirect_to @event, message
  end

  private

  def notify_subscribers(event, comment)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq
    all_emails.delete(comment.user.email) if comment.user

    all_emails.each do |mail|
      EventMailer.comment(event, comment, mail).deliver_now
    end
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name )
  end
end