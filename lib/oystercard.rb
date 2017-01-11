require "./lib/journey_log"

class Oystercard
MAX_BALANCE = 90
MIN_BALANCE = 1

attr_reader :balance, :journey_log

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new
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
    self.touch_out(nil) if !journey_log.journey_nil?
    raise "Insufficient balance. Top up to at least #{MIN_BALANCE}!" if below_minimum?
    @journey_log.start_journey(station)
  end

  def touch_out(exit_station)
    check_and_end_journey(exit_station)
    deduct(journey_log.current_journey.fare)
    journey_log.reset_journey
  end


  private
  def deduct(fare)
    @balance -= fare
  end

  def check_and_end_journey(exit_station)
    journey_log.start_journey(nil) if journey_log.journey_nil?
    journey_log.end_journey(exit_station)
  end
end
