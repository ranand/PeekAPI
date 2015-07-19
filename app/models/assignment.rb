# Author : Anand Ramakrishnan
# Date   : 07/18/2015

class Assignment < ActiveRecord::Base
  belongs_to :timeslot
  belongs_to :boat
end
