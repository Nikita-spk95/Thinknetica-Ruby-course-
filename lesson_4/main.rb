require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'carriage'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

class Main

  def initialize
    @trains = []
    @stations = []
    @routes = []
  end

  def main_menu
      puts "(Введите порядковый номер необходимой команды)"
      puts "Главное меню:"

    loop do 
      puts
      puts "Раздел - Управление поездами:"
      puts
      puts "1.  Создать поезд"
      puts "2.  Список поездов"
      puts "3.  Прицепить вагон к поезду"
      puts "4.  Отцепить вагон от поезда"
      puts "5.  Назначить маршрут поезду" 
      puts "6.  Отправить поезд на след. станцию" 
      puts "7.  Отправить поезд на пред. станцию"
      puts
      puts "Раздел - Управление станциями:"
      puts
      puts "8.  Создать станцию"
      puts "9.  Список станций"
      puts "10. Список поездов на станции"
      puts "11. Добавление станции к маршруту" 
      puts "12. Удаление станции из маршрута" 
      puts
      puts "Раздел - Управление маршрутами:"
      puts
      puts "13. Создать маршрут"
      puts "14. Список маршрутов"
      puts
      puts "15. Выход из программы"
      puts

      choice = gets.chomp.to_i

      case choice

      when 1
        create_train
      when 2
        trains_list
      when 3
        add_carriage_to_train
      when 4
        remove_carriage_of_train
      when 5
        add_route_to_train
      when 6
        move_train_forward
      when 7
        move_train_backward
      when 8
        create_station
      when 9
        stations_list
      when 10
        trains_list_on_station
      when 11
        add_station_to_route
      when 12
        remove_station_from_route
      when 13
        create_route
      when 14
        routes_list
      when 15
        break
      else
        puts "Введите корректный номер команды."
      end
    end
  end

  def create_train
    puts "Сперва укажите номер вашего поезда"
    number = gets.chomp.to_i
    puts "Укажите порядковый номер требуемого типа поезда: 1. пассажирский; 2. грузовой"
    train_type = gets.chomp.to_i

    case train_type
    when 1
      passenger_train = PassengerTrain.new(number)
      @trains << passenger_train
      puts "Пассажирский поезд под номером #{number} успешно создан!"
      puts "Обратите внимание! К пассажирскому поезду можно присоеденить только пассажирские вагоны!"
      puts "Обратите внимание! Прицепка и отцепка вагонов происходит только при полной остановке поезда!"      
    when 2
      cargo_train = CargoTrain.new(number)
      @trains << cargo_train
      puts "Грузовой поезд под номером #{number} успешно создан!"
      puts "Обратите внимание! К грузовому поезду можно присоеденить только грузовые вагоны!"  
      puts "Обратите внимание! Прицепка и отцепка вагонов происходит только при полной остановке поезда!"      
    else
      puts "Введите коректный тип поезда"
    end
  end

  def trains_list
    puts "Список поездов:"
    @trains.each_with_index do |train, index|
      puts "#{index}. Номер поезда: #{train.number}, Тип поезда: #{train.type}, Количество вагонов: #{train.carriages_count}"
    end
  end

  def find_train
    trains_list

    puts "Введите порядковый номер требуемого поезда:"
    @train_number = gets.chomp.to_i
    puts "Введите требуемое количество вагонов:"
    @carriage_count = gets.chomp.to_i
  end 

  def add_carriage_to_train
    find_train
    
    train = @trains[@train_number]
    if train.type == :cargo
      @carriage_count.times { train.take_carriage(CargoСarriage.new) }
    else
      @carriage_count.times { train.take_carriage(PassengerСarriage.new) }
    end  
    puts "Вагон добавлен"
  end

  def remove_carriage_of_train
    find_train
    
    train = @trains[@train_number]
    @carriage_count.times { train.drop_carriage }
   
    puts "Вагон отцеплен"
  end

  def add_route_to_train
    puts "Выберите номер маршрута к которому хотите добавить поезд"
    routes_list
    route_number = gets.chomp.to_i
    trains_list
    puts "Укажите порядковый номер поезда который хотите добавить к маршруту"
    train_number = gets.chomp.to_i

    route = @routes[route_number]
    train = @trains[train_number]
    train.take_route(route)
    
    puts "Поезд на станции #{train.current_station.name}"
  end

  def move_train_forward 
    trains_list

    puts "Укажите порядковый номер поезда, который отправится на следующую станцию"
    train_index = gets.chomp.to_i
    train = @trains[train_index]
    train.move_forward
    puts "Поезд отправился на следующую станцию #{train.current_station.name}"
  end

  def move_train_backward
    trains_list

    puts "Укажите номер поезда, который отправится на предыдущую станцию"
    train_index = gets.chomp.to_i
    train = @trains[train_index]
    train.move_backward
    puts "Поезд отправился на предыдущую станцию #{train.current_station.name}"
  end

  private # у классов приведённых ниже нет наследования

  def create_station
    puts "Введите название вашей станции: "
    station_name = gets.chomp.to_s.downcase
    station =  Station.new(station_name)
    @stations << station
    puts "Ваша станция #{station_name} создана!"
  end

  def stations_list
    return unless @stations.any?
    puts "Список станций:"
    @stations.each_with_index do |station, index|
      puts "#{index}. #{station.name}"
    end
  end

  def trains_list_on_station
    stations_list
    puts "Введите номер станции для вывода списка поездов"
    get_number = gets.chomp.to_i 
    puts "На станции #{@stations[get_number].name} поезда:"
    station = @stations[get_number].trains
    station.each_with_index do |train, index| 
      puts "#{index}. Номер поезда: #{train.number}, Тип поезда: #{train.type}, Количество вагонов: #{train.carriages_count}"
    end
  end

  def add_station_to_route
    puts "Выберите номер маршрута к которому хотите добавить станцию"
    routes_list
    user_input = gets.chomp.to_i

    stations_list
    puts "Введите номер станции которую хотите добавить"
    user_choice = gets.chomp.to_i 

    @routes[user_input].add_station(@stations[user_choice])
    puts "Станция добавлена"
  end

  def remove_station_from_route
    puts "Выберите номер маршрута в котором хотите удалить станцию"
    routes_list
    user_input = gets.chomp.to_i
    
    stations_list
    puts "Введите номер станции которую хотите удалить"
    user_choice = gets.chomp.to_i 

    @routes[user_input].remove_station(@stations[user_choice])
    puts "Станция удалена" 
  end

  def create_route
    stations_list

    puts "Введите порядковый номер начальной станции"
    first_station = gets.chomp.to_i
    puts "Введите порядковый номер конечной станции"
    last_station = gets.chomp.to_i
    route = Route.new(@stations[first_station], @stations[last_station])
    @routes << route 
    puts "Маршрут создан."
  end

  def routes_list
    puts "Список маршрутов:"
    @routes.each_with_index do |route, index|
      puts "#{index}. #{route.stations}"
    end
  end
end
Main.new.main_menu
