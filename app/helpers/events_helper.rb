module EventsHelper
  def render_events(collection)
    return "Пока нет ни одного события." unless @events.present?
    render partial: 'partials/event', collection: collection
  end
end
