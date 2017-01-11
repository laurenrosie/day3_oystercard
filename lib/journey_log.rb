require "./lib/journey"

class JourneyLog

attr_reader :journeys , :current_journey, :journey_class

  def initialize
    @journeys = []
    @current_journey = nil
    @journey_class = Journey
  end


  def start_journey(entry_station)
    @current_journey = journey_class.new(entry_station)
  end

  def end_journey(exit_station)
    @current_journey.finish(exit_station)
    update_list(current_journey)
  end

  def update_list(current_journey)
    journeys << {entry_station: current_journey.entry_station, exit_station: current_journey.exit_station}
  end

  def journey_nil?
    current_journey == nil
  end

  def reset_journey
    @current_journey = nil
  end

  context "when testing zone fare" do

  end



end
