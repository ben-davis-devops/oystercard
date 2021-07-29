require_relative 'journey.rb'

class Oystercard
  attr_reader :balance, :journey_log

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey = Journey.new

  end

  def top_up(money)
    @balance += money
    raise 'Maximum balance exceeded' if @balance > MAXIMUM_BALANCE
  end

  def touch_in(name, zone)
    raise 'You cannot ride - you broke' if no_funds
    @journey.start(name, zone)
  end

  def touch_out(name, zone)
    @journey.finish(name, zone)
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    !!entry_station
  end 

  private 

  def no_funds
    return @balance <= DEFAULT_BALANCE ? true : false
  end

  def deduct(fare)
    @balance -= fare
  end

end

