require_relative 'station.rb'

class Journey
  attr_accessor :entry_station, :exit_station

  def initialize
    @journey_log = []
    @entry_station = Station.new
    @exit_station = Station.new
  end

  def start(entry_station, zone)
    @journey = Journey.new
    @journey.entry_station.name = entry_station
    @journey.entry_station.zone = zone
  end

  def finish(exit_station, zone)
    @journey.exit_station.name = exit_station
    @journey.exit_station.zone = zone
    @journey_log.push({entry: @journey.entry_station.name, exit: @journey.exit_station.name})
  end

  def fare
  end
end