require 'sinatra/base'
require_relative 'lib/board'
require_relative 'lib/cell'
require_relative 'lib/water'
require_relative 'lib/ship'
require_relative 'lib/player'

# enable :sessions

class BattleshipsWeb < Sinatra::Base

  set :views, proc { File.join(root, 'views') }

  get '/' do
    erb :index
  end

  get '/name_input' do
    @name = params[:name]
    @board = Board.new(Cell)
    @ship = Ship.new(4)
    @ship2 = Ship.new(2)
    @board.place(@ship, :A1)
    @board.place(@ship2, :D3, :vertically)
    @board.shoot_at(:A1)
    @board.shoot_at(:E4)
    erb :name_input
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
