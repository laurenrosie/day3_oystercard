class Journey

  attr_reader :entry_station, :exit_station
  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station
  end

  def journey_complete?
    !(exit_station == nil)
  end

  def finish(finish_station)
    @exit_station = finish_station
  end

  def fare
    if @entry_station==nil || @exit_station == nil
      6
    else
      1
    end
  end
end
