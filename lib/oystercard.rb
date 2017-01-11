require "./lib/journey"

class Oystercard
MAX_BALANCE = 90
MIN_BALANCE = 1
attr_reader :balance, :journeys, :current_journey

  def initialize
    @balance = 0
    @journeys = []
    @current_journey = nil
  end

  def top_up(money)
  raise "the maximum allowed balance is #{MAX_BALANCE} !" if over_limit?(money)
  @balance += money
  end

  def over_limit?(money)
    balance + money > MAX_BALANCE
  end

  def below_minimum?
    balance < MIN_BALANCE
  end

  def touch_in(station)
    self.touch_out(nil) if !journey_nil?#if current journey NOT nil, then start a new journey with no entry point
    raise "Unsuffient balance. Top up to at least #{MIN_BALANCE}!" if below_minimum?
    @current_journey = Journey.new(station)
  end

  def touch_out(exit_station)
    check_and_end_journey(exit_station)
    deduct(current_journey.fare)
    update_history
  end


  private
  def deduct(fare)
    @balance -= fare
  end

  def journey_nil?
    @current_journey == nil
  end

  def update_history
    @journeys << {entry_station: current_journey.entry_station, exit_station: current_journey.exit_station}
    @current_journey = nil
  end

  def check_and_end_journey(exit_station)
    @current_journey = Journey.new(nil) if journey_nil?
    @current_journey.finish(exit_station)
  end
end
