# Author : Anand Ramakrishnan
# Date   : 07/18/2015

class Booking < ActiveRecord::Base
	belongs_to :timeslot
end
