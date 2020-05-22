module EventsHelper
  def render_events
    return "Пока нет ни одного события." unless @events.present?
    render partial: 'partials/event', collection: @events
  end
end
