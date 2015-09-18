class Board
	attr_reader :grid

	def initialize(cell)
		@grid = {}
		[*"A".."J"].each do |l|
			[*1..10].each do |n|
			  @grid["#{l}#{n}".to_sym] = cell.new
		    @grid["#{l}#{n}".to_sym].content = Water.new
		  end
	  end
  end

	def show
		output = ""
	  [*"A".."J"].each do |l|
	    [*1..10].each do |n|
	      if grid["#{l}#{n}".to_sym].hit? && grid["#{l}#{n}".to_sym].content.is_a?(Ship)
	        output += "<div class='hit_ship' style= 'width: 55px; height: 55px;
             display: inline-block;
             border: 1px rgb(89,89,89) solid;
             padding: 0px;
             background: rgb(0, 255, 0);'></div>"
			 elsif grid["#{l}#{n}".to_sym].content.is_a?(Ship)
				output += "<div class='miss' style= 'width: 55px; height: 55px;
					display: inline-block;
					border: 1px rgb(89,89,89) solid;
					padding: 0px;
					background: rgb(160,82,45);'></div>"
			  elsif grid["#{l}#{n}".to_sym].hit?
					output += "<div class='miss' style= 'width: 55px; height: 55px;
					  display: inline-block;
				  	border: 1px rgb(89,89,89) solid;
				  	padding: 0px;
				  	background: rgb(255, 0, 0);'></div>"
	      else
          output += "<div class='water' style= 'width: 55px; height: 55px;
	          display: inline-block;
	          border: 1px rgb(89,89,89) solid;
	          padding: 0px;
	          background: rgb(73, 244, 249);'></div>"
	      end
	    end
	  end
		output
	end

	def place(ship, coord, orientation = :horizontally)
		coords = [coord]
		((ship.size)-1).times{coords << next_coord(coords.last, orientation)}
		put_on_grid_if_possible(coords, ship)
	end

	def rand_coord
    letter = [*"A".."J"].shuffle.pop
    number = [*1..10].shuffle.pop
    rand_coord = letter + number.to_s
    rand_coord.to_sym
  end

  def rand_orientation
    rand_orientation = [:horizontal, :vertical].shuffle.pop
  end

	def rand_place(ship)
		coord = rand_coord
		orientation = rand_orientation
		begin
			place(ship, coord, orientation)
		rescue
			rand_place(ship)
		end
	end

	def floating_ships?
		ships.any?(&:floating?)
	end

	def shoot_at(coordinate)
		raise "You cannot hit the same square twice" if  grid[coordinate].hit?
		grid[coordinate].shoot
	end

	def ships
		grid.values.select{|cell|is_a_ship?(cell)}.map(&:content).uniq
	end

	def ships_count
		ships.count
	end

private

 	def next_coord(coord, orientation)
		orientation == :vertically ? next_vertical(coord) : coord.next
	end

	def next_vertical(coord)
		coord.to_s.reverse.next.reverse.to_sym
	end

	def is_a_ship?(cell)
		cell.content.respond_to?(:sunk?)
	end

	def any_coord_not_on_grid?(coords)
		(grid.keys & coords) != coords
	end

	def any_coord_is_already_a_ship?(coords)
		coords.any?{|coord| is_a_ship?(grid[coord])}
	end

	def raise_errors_if_cant_place_ship(coords)
		raise "You cannot place a ship outside of the grid" if any_coord_not_on_grid?(coords)
		raise "You cannot place a ship on another ship" if any_coord_is_already_a_ship?(coords)
	end

	def put_on_grid_if_possible(coords, ship)
		raise_errors_if_cant_place_ship(coords)
		coords.each{|coord|grid[coord].content = ship}
	end

end
