class PhotosController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_photo, only: [:destroy]

  def create
    if current_user_sub?(@event) || current_user_can_edit?(@event)
      @new_photo = @event.photos.build(photo_params)

      @new_photo.user = current_user

      if @new_photo.save
        notify_subscribers(@event, @new_photo)

        flash[:notice] = I18n.t('helpers.controllers.photos.created')
        redirect_to @event
      else
        flash.now[:alert] = @new_photo.errors.full_messages
        render 'events/show'
      end
    else
      flash[:alert] = I18n.t('helpers.controllers.photos.not_signed_in')
      render 'events/show'
    end
  end

  def destroy
    message = {notice: I18n.t('helpers.controllers.photos.destroyed')}

    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      message = {alert: I18n.t('helpers.controllers.photos.error')}
    end

    redirect_to @event, message
  end

  private

  def notify_subscribers(event, photo)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq
    all_emails.delete(photo.user.email)

    all_emails.each do |mail|
      EventMailer.photo(event, photo, mail).deliver_now
    end
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_photo
    @photo = @event.photos.find(params[:id])
  end

  def photo_params
    params.fetch(:photo, {}).permit(:photo, :discription)
  end
end
