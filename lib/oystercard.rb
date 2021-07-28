class Oystercard
  attr_reader :balance, :entry_station, :exit_station
  attr_accessor :journey_log

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    # @journey = journey
    @entry_station = nil
    @exit_station = nil
    @journey_log = []
  end

  def top_up(money)
    @balance += money
    raise 'Maximum balance exceeded' if @balance > MAXIMUM_BALANCE 
  end

  def touch_in(station)
    raise 'You cannot ride - you broke' if no_funds
    
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    # add journey_log here
    add_journey
    @entry_station = nil
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

  def add_journey
    @journey_log.push({entry: @entry_station, exit: @exit_station})
  end

end

