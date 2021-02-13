class Station
  attr_reader :trains , :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def train_arrived(train)
    @trains << train
  end

  def train_send(train)
    @trains.delete(train)
  end

  def show_cargo_trains
    @trains.select { |train| train == :cargo }
  end

  def show_coach_trains
    @trains.select { |train| train == :coach }
  end
end
