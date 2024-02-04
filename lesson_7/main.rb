require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'company_manufacture'
require_relative 'validation'

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
      puts "`````````````````````````````"
      puts "Раздел - Управление поездами:"
      puts
      puts "1.  Создать поезд"
      puts "2.  Список поездов"
      puts "3.  Прицепить вагон к поезду"
      puts "4.  Занять пассажирские места"
      puts "5.  Загрузить грузовой вагон"
      puts "6.  Отцепить вагон от поезда"
      puts "7.  Назначить маршрут поезду" 
      puts "8.  Отправить поезд на след. станцию" 
      puts "9.  Отправить поезд на пред. станцию"
      puts
      puts "Раздел - Управление станциями:"
      puts
      puts "10. Создать станцию"
      puts "11. Список станций"
      puts "12. Список поездов на станции"
      puts "13. Добавление станции к маршруту" 
      puts "14. Удаление станции из маршрута" 
      puts
      puts "Раздел - Управление маршрутами:"
      puts
      puts "15. Создать маршрут"
      puts "16. Список маршрутов"
      puts "17. Выход из программы"
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
        take_a_seat
      when 5
        fill_cargo
      when 6
        remove_carriage_of_train
      when 7
        add_route_to_train
      when 8
        move_train_forward
      when 9
        move_train_backward
      when 10
        create_station
      when 11
        stations_list
      when 12
        trains_list_on_station
      when 13
        add_station_to_route
      when 14
        remove_station_from_route
      when 15
        create_route
      when 16
        routes_list
      when 17
        break
      else
        puts "Введите корректный номер команды."
      end
    end
  end

  private

  def create_train
    puts "Сперва укажите номер вашего поезда"
    number = gets.chomp.to_s
    puts "Укажите порядковый номер требуемого типа поезда: 1. пассажирский; 2. грузовой"
    train_type = gets.chomp.to_i

    case train_type
    when 1
      passenger_train = PassengerTrain.new(number)
      @trains << passenger_train
      puts "Пассажирский поезд под номером #{number} успешно создан!"
    when 2
      cargo_train = CargoTrain.new(number)
      @trains << cargo_train
      puts "Грузовой поезд под номером #{number} успешно создан!"
    else
      puts "Введите коректный тип поезда"
    end
  rescue ArgumentError => e
    puts e.message
    retry
  end

  def trains_list
    puts "Список поездов:"
    @trains.each_with_index do |train, index|
      puts "#{index}. Номер поезда: #{train.number}, Тип поезда: #{train.type}, Количество вагонов: #{train.carriages_count}"
    end
  end

  def find_train
    trains_list

    puts "Введите индекс требуемого поезда:"
    @train_number = gets.chomp.to_i
  end 

  def add_carriage_to_train
    find_train
    
    train = @trains[@train_number]
    puts "Укажите количество вагонов:"
    @carriage_count = gets.chomp.to_i  
    if train.type == :passenger
      puts "Укажите количество мест в вагоне: "
      seats_count = gets.chomp.to_i
      @carriage_count.times { train.take_carriage(PassengerСarriage.new(seats_count)) }
      puts "Пассажирские вагоны добавлены, количество мест: #{seats_count}"
    elsif train.type == :cargo
      puts "Укажите объем грузового вагона: "
      volume_count = gets.chomp.to_i
      @carriage_count.times { train.take_carriage(CargoСarriage.new(volume_count)) }
      puts "Грузовые вагоны добавлены, с объемом для загрузки #{volume_count}"
    else
      puts "Введите коректный тип вагона"
    end  

  rescue ArgumentError => e
    puts e.message
    retry
  end

  def take_a_seat
    trains_list
    train = @trains[@train_number]
    return puts "Выберите пассажирский тип поезда!" unless train.type == :passenger
    puts
    puts "Информация о поезде:"
    puts "Номер поезда: #{train.number}"
    puts "Тип поезда: #{train.type}"
    puts "Количество вагонов в поезде: #{train.carriages_count}"
    puts
    puts "Информация о вагонах:"
    train.carriages_info do |car|
      puts "Тип вагона: #{car.type}, Количество мест: #{car.seats}"
      puts "Количеcтво свободных мест: #{car.free_seats}" 
      puts
    end
    puts "Укажите номер вагона в котором хотите купить билет"
    carriage_number = gets.chomp.to_i
    carriage = train.carriages[carriage_number - 1]
    carriage.fill_carriage
    puts "Билет приобретен вагоне №#{carriage_number}"
  end

  def fill_cargo
    trains_list
    train = @trains[@train_number]
    return puts "Выберите грузовой тип поезда!" unless train.type == :cargo
    puts
    puts "Информация о поезде:"
    puts "Номер поезда: #{train.number}"
    puts "Тип поезда: #{train.type}"
    puts "Количество вагонов в поезде: #{train.carriages_count}"
    puts
    puts "Информация о вагонах:"
    train.carriages_info do |car|
      puts "Тип вагона: #{car.type}, объем: #{car.volume}"
      puts "Свободный объем: #{car.free_volume}" 
      puts
    end
    puts "Укажите номер вагона к загрузке"
    carriage_number = gets.chomp.to_i
    carriage = train.carriages[carriage_number - 1]
    puts "Укажите объем"
    carriage_volume = gets.chomp.to_i
    carriage.fill_volume(carriage_volume)
    puts "Вы загрузили вагон №#{carriage_number}"
    puts "Оставшийся свободный объем #{carriage.free_volume}"
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

  def create_station
    puts "Введите название вашей станции: "
    station_name = gets.chomp.to_s.downcase
    station =  Station.new(station_name)
    @stations << station
    puts "Ваша станция #{station_name} создана!"
  rescue ArgumentError => e
    puts e.message
    retry
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
      if train.type == :passenger
        train.carriages_info { |car| puts "  Тип вагона: #{car.type}, Количество мест: #{car.seats}, Количеcтво свободных мест: #{car.free_seats}" }
      elsif train.type == :cargo
        train.carriages_info { |car| puts "  Тип вагона: #{car.type}, объем: #{car.volume}, Свободное пространство: #{car.free_volume}" }
      end
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
  rescue ArgumentError => e
    puts e.message
    retry
  end

  def routes_list
    puts "Список маршрутов:"
    @routes.each_with_index do |route, index|
      puts "#{index}. #{route.stations}"
    end
  end
end
Main.new.main_menu
