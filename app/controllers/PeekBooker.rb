# Author : Anand Ramakrishnan
# Date   : 07/18/2015

# PeekBooker class to help the different controllers.

class PeekBooker

  # Timeslot Controller helpers.

  def self.delete_timestaps(object)
    object.attributes.delete_if{|k, v| k == "created_at" || k == "updated_at"}
  end

  # We need to mark if there is an overlap and if a boat is booked.
  def self.register_overlaping
    timeslots = Timeslot.all
    timeslots.each do |timeslot|
      init = timeslot.start_time
      timeslots.each do |timeslot_to_compare|
        start_time = timeslot_to_compare.start_time
        finish_time = timeslot_to_compare.start_time + (timeslot_to_compare.duration * 60)

        if (start_time..finish_time).include?(init) && timeslot_to_compare.id != timeslot.id
          timeslot.booked = timeslot_to_compare.id
          timeslot_to_compare.booked = timeslot.id
          timeslot.save
          timeslot_to_compare.save
        end
      end
    end
  end

  
  # Assignment Controller Helpers

  # Assign a boat.
  def self.assign_boat(boat_id)
    boat = Boat.find(boat_id)
    boat.used = false
    boat.save
  end

  # Update a boat's status (number of seats etc) based on timeslot.
  def self.upd_boat_status(timeslot_id)
    timeslot = Timeslot.find(timeslot_id)
    # Check if there are any bookings
    if timeslot.bookings.size > 0
      used_seats = timeslot.bookings.map(&:size).reduce(:+)
    else
      used_seats = 0
    end

    # Check if the boats are used.
    if timeslot.boats.map(&:used).include?(true)
      timeslot.availability =  timeslot.boats.where(used: false).map(&:capacity).reduce(:+)
      timeslot.save
    else
      timeslot.availability = timeslot.boats.map(&:capacity).reduce(:+) - used_seats
      timeslot.save
    end
  end


  # Booking Controller Helpers

  # Update a boat (whether available or not)
  def self.upd_availability(timeslot_id)
    timeslot = Timeslot.find(timeslot_id)

    if timeslot.bookings.size > 0
      used_seats = timeslot.bookings.map(&:size).reduce(:+)
      timeslot.customer_count = used_seats
      timeslot.save
    else
      used_seats = 0
    end

    if timeslot.boats.map(&:used).include?(true)
      timeslot.availability =  timeslot.boats.where(used: false).map(&:capacity).reduce(:+)
      timeslot.save
    else
      timeslot.availability = timeslot.boats.map(&:capacity).reduce(:+) - used_seats
      timeslot.save
    end
  end

  # We need to make sure we use a boart and mark so.
  def self.use_a_boat(booking_size, timeslot_id)
    capacity_available = {}

    timeslot = Timeslot.find(timeslot_id)
    timeslot.boats.each do |boat|
      capacity_available[boat.id] = boat.capacity
    end

    if timeslot.boats.size > 1
      capacity_available.each do |boat_id, capacity|
        if booking_size <= capacity && booking_size > (capacity / 2)
          boat = Boat.find(boat_id)
          boat.used = true
          boat.save
        end
      end
    end
  end

  def self.delete_overlap_assignments(id)
      timeslot = Timeslot.find(id)
      assignment_to_check = Assignment.find_by_timeslot_id(id)
      assignment_to_delete = Assignment.find_by_timeslot_id(timeslot.booked)

      if timeslot.booked != 0 && assignment_to_delete.boat_id  == assignment_to_check.boat_id
        assignment_to_delete.destroy!
        timeslot_overlap = Timeslot.find(timeslot.booked)
        timeslot_overlap.availability = 0
        timeslot_overlap.save
      end
  end
end