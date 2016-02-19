module CalendarHelper
  def render_calendar(opts={})
    options = opts

    render(
      partial: "calendar", 
      locals: { 
        date_range: date_range(options), 
        start_date: start_date,
        sorted_events: sorted_events(options)
      }
    )
  end

  private
    def sorted_events(options)
      events = options.fetch(:events, []).sort_by(&:start_date)
      sorted = {}

      events.each do |event|
        date = event.start_date.to_date
        sorted[date] ||= []
        sorted[date] << event
      end
      sorted
    end

    def start_date
      params.fetch(:start_date,  Date.today).to_date
    end

    def date_range(options)
      (start_date..(start_date + additional_days(options).days)).to_a
      #(start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week).to_a
    end

    def additional_days(options)
      options.fetch(:number_of_days, 4) - 1
    end
end
