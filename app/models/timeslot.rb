# Author : Anand Ramakrishnan
# Date   : 07/18/2015

class Timeslot < ActiveRecord::Base
	
  # foreign key declarations
	has_many :assignments
	has_many :bookings 
	has_many :boats, through: :assignments

	# query the db for data from the entire day.
	def self.get_ts_data(date)
    	self.where(start_time: unix_timestamp_min(date)..unix_timestamp_max(date))
  end

  private

  # Some private methods for unix time conversion

  def self.unix_timestamp(date)
  		# We can't convert date in yyyy-mm-dd format directly, so
  		# strip and then get the unix timestamp.
	    date_arr = date.split('-').map!(&:to_i)
	    year, month, day = date_arr[0], date_arr[1], date_arr[2]
	    return Date.new(year, month, day).to_time.to_i
  end

  def self.unix_timestamp_min(date)
    	unix_timestamp(date)
  end

  def self.unix_timestamp_max(date)
  		# there are 86400 seconds in a day.
    	unix_timestamp_min(date) + 86399
  end
end
