# Author : Anand Ramakrishnan
# Date   : 07/18/2015

class Boat < ActiveRecord::Base
	has_many :assignments
    has_many :timeslots, through: :assignments
end
