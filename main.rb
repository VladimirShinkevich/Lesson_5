require_relative "station"
require_relative "train"
require_relative "route"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "wagon"
require_relative "passenger_wagon"
require_relative "cargo_wagon"

class Menu
  private
  attr_writer :trains, :stations, :routes

  public
  attr_reader :routes, :stations, :trains

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @stop = false
  end

  MAIN_MENU = %Q(
    1. Create train station or route
    2. Perform operations with the created objects
    3. Get current data about objects
    4. Exit)

  CREATE_MENU = %Q(
    1. Create train
    2. Create route
    3. Create station)

  PERFORM_MENU = %Q(
    1. Add a train route
    2. Add a carriage to the train
    3. Unhook the car from the train
    4. Move the train forward
    5. Move the train back)

  TRAIN_MENU = %Q(
    1. Train management
    2. Route management)

  ROUTE_MENU = %Q(
    1. Adding a station to a route
    2. Removing a station from the route)

  def start_railway
    loop do
      if @stop
        puts "Good bay!!!"
        break
      else
        puts MAIN_MENU
        print "Enter action: "
        choose = gets.chomp.to_i
        main_menu(choose)
      end
    end
  end

  private

  def main_menu(choose)
    case choose
    when 1
      create_object
    when 2
      perform_menu
    when 3
      show_railway
    when 4
      @stop = true
    end
  end

  def create_object
    puts CREATE_MENU
    choose = gets.chomp.to_i
    case choose
    when 1
      create_train
    when 2
      create_route
    when 3
      create_station
    end
  end

  def perform_menu
    puts TRAIN_MENU
    choose = gets.chomp.to_i
    case choose
    when 1
      trains_manage
    when 2
      routes_manage
    end
  end

  def trains_manage
    @trains.each_with_index {|train, index| puts "#{index}: #{train}"}
    print "Enter train index: "
    train_index = gets.chomp.to_i
    puts PERFORM_MENU
    print "What do you what to do?"
    choose = gets.chomp.to_i
    case choose
    when 1
      add_train_to_route(train_index)
    when 2
      add_wagons_to_train(train_index)
    when 3
      delete_train_wagons(train_index)
    when 4
      move_train_next_station(train_index)
    when 5
      move_train_prev_station(train_index)
    end
  end

  def routes_manage
    @routes.each_with_index {|route, index| puts "#{index}: #{route.show_route.map {|station| station}}"}
    print "Enter route index: "
    route_index = gets.chomp.to_i
    ROUTE_MENU
    choose = gets.chomp.to_i
    case choose
    when 1
      add_stations_to_route(route_index)
    when 2
      delete_stations_from_route(route_index)
    end
  end

  def show_railway
    @trains.each_with_index  do |train, index|
      puts "Index: #{index}, number #{train}"
    end

    @routes.each_with_index do |route, index|
      puts "#{index}: #{route}"
    end

    @stations.each_with_index do |station, index|
      puts "#{index}: #{station}"
    end
  end

  def create_station
    print "Enter station name: "
    station_name = gets.chomp
    @stations << Station.new(station_name)
    puts "Station add."
  end

  def create_train
    print "Enter train number: "
    train_number = gets.chomp.to_i
    puts "Passenger type = 1\n Cargo type = 2"
    print "Enter train type: "
    train_type = gets.chomp.to_i
    @trains << PassengerTrain.new(train_number) if train_type == 1
    @trains << CargoTrain.new(train_number) if train_type == 2
    puts "Train add."
  end

  def create_route
    puts "Choose station index!"
    @stations.each_with_index {|station, index| puts "#{index}: #{station}"}
    print "Enter start station index: "
    start_station_index = gets.chomp.to_i
    print "Enter end station: "
    end_station_index = gets.chomp.to_i
    @routes << Route.new(@stations[start_station_index], @stations[end_station_index])
    puts "Route add."
  end

  def add_train_to_route(train_index)
    @routes.each_with_index { |route, index| puts "#{index}: #{route}" }
    print "Enter route index: "
    route_index = gets.chomp.to_i
    @trains[train_index].train_route(@routes[route_index])
    puts "Train on route."
  end

  def add_wagons_to_train(train_index)
    wagon = CargoWagon.new(CargoWagon::TYPE) if @trains[train_index].type == :cargo
    wagon = PassengerWagon.new(PassengerWagon::TYPE) if @trains[train_index].type == :passenger
    @trains[train_index].add_wagon(wagon)
    puts "Wagons added to train."
  end

  def delete_train_wagons(train_index)
    @trains[train_index].delete_wagon
    puts "Wagon is remove from train."
  end

  def move_train_next_station(train_index)
    @trains[train_index].train_moving_next
  end

  def move_train_prev_station(train_index)
    @trains[train_index].train_moving_prev
  end

  def add_stations_to_route(route_index)
    @stations.each_with_index {|station, index| puts "#{index}: #{station}"}
    print "Enter station index: "
    station_index = gets.chomp.to_i
    @route[route_index].add_intermediate_station(@stations[station_index])
  end

  def delete_stations_from_route(route_index)
    @stations.each_with_index {|station, index| puts "#{index}: #{station}"}
    print "Enter station index: "
    station_index = gets.chomp.to_i
    station = @routes[route_index].show_route[station_index]
    @route[route_index].delete_intermediate_station(station)
  end
end

railway = Menu.new
railway.start_railway
