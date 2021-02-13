class Train
  attr_reader :speed, :current_station, :route, :number, :type, :wagons_list

  private

  attr_writer :speed, :current_station, :route, :wagons_list

  public

  def initialize(number, type)
    @number = number
    @type = type
    @wagons_list = []
    @speed = 0
  end

  def go(speed)
    self.speed += speed
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
   wagons_list << wagon if (@speed == 0) && (wagon.type == type)
  end

  def delete_wagon
      wagons_list.pop if @speed == 0
  end

  def train_route(route)
    @route = route
    @current_station = route.starting_station
  end

  def next_station
    return if @current_station == @end_station
    station_index = route.show_route.index(@current_station)
    @current_station = route.show_route[station_index + 1]
  end

  def prev_station
    return if @current_station >= route.starting_station
    station_index = route.show_route.index(@current_station)
    @current_station = route.show_route[station_index - 1]
  end

  def train_moving_next
    return unless next_station
    @current_station.train_send(self)
    @current_station = next_station
    @current_station.train_arrived(self)
  end

  def train_moving_prev
    return unless prev_station
    @current_station.train_send(self)
    @current_station = prev_station
    @current_station.train_arrived(self)
  end

end
