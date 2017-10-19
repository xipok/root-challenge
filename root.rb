class Driver
	attr_accessor :total_distance, :total_time, :name
	@@drivers = []

	def initialize (name)
		@name = name
		@total_distance = 0
		@total_time = 0
		@@drivers << self
	end

	def self.report
		@@drivers.sort_by! {|d| d.total_distance}.reverse!
		@@drivers.each do |d|
			if d.total_time == 0
				puts "#{d.name}: #{d.total_distance.round} miles @ 0 mph"
			else 
				mph = d.total_distance/d.total_time
				puts "#{d.name}: #{d.total_distance.round} miles @ #{mph.round} mph"
			end
		end
	end

	def self.trip_by_name(name, start_time, end_time, miles_driven)
		@@drivers.each do |d|
			if d.name === name
				# in hours:
				trip_time = (Time.new(2017,1,1,end_time.split(':')[0],end_time.split(':')[1])-Time.new(2017,1,1,start_time.split(':')[0],start_time.split(':')[1]))/3600
				avg_speed = miles_driven/trip_time
				if (avg_speed > 5) && (avg_speed < 100)
					d.total_time += trip_time
					d.total_distance += miles_driven
				end
			end
		end
	end
end

# d1=Driver.new('Dan')
# d2=Driver.new('Alex')
# d3=Driver.new('Bob')
# d1.trip('07:15','07:45',17.3)
# d1.trip('06:12','06:32',21.8)
# d2.trip('12:01','13:16',42.0)
# Driver.report

# parse input file
# format: command, *command_args
input_file = ARGV[0]
File.open(input_file).readlines.each do |l|
	if l.split[0] === "Driver"
		Driver.new(l.split[1])
	elsif l.split[0] === "Trip"
		Driver.trip_by_name(l.split[1],l.split[2],l.split[3],l.split[4].to_f)
	end
end
Driver.report