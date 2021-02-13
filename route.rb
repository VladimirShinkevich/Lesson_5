class Route
  attr_accessor :starting_station, :end_station, :intermediate_stations

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @intermediate_stations = []
  end

  def add_intermediate_station(station)
    @intermediate_stations << station
  end

  def delete_intermediate_station(station)
    @intermediate_stations.delete(station)
  end

  def show_route
   [@starting_station, *@intermediate_stations, @end_station]
  end
end
