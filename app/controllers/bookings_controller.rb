# Author : Anand Ramakrishnan
# Date   : 07/18/2015

require 'PeekBooker'

class BookingsController < ApplicationController
	
	# We need these to help with CORS issue 
	skip_before_filter :verify_authenticity_token
  	before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers

	def index
	end	

	# returns data when /api/bookings POST is called.
	def create
		booking = Booking.new(booking_params)

	    if booking.save
	    	PeekBooker.use_a_boat(booking.size, booking.timeslot_id)
	    	PeekBooker.delete_overlap_assignments(booking.timeslot_id)
	    	PeekBooker.upd_availability(booking.timeslot_id)
	      	
	      	render json: booking, status: 201
	    end
	end

	def show
	end

	def edit
	end

	def destroy
	end

	private

	# booking params that we need.
	def booking_params
		params.require(:booking).permit(:timeslot_id, :size)
	end

	# For all responses in this controller, return the CORS access control headers.
	def cors_set_access_control_headers
	    headers['Access-Control-Allow-Origin'] = '*'
	    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
	    headers['Access-Control-Max-Age'] = "1728000"
	end

  	# If this is a preflight OPTIONS request, then short-circuit the
  	# request, return only the necessary headers and return an empty
  	# text/plain.

  	def cors_preflight_check
    	headers['Access-Control-Allow-Origin'] = '*'
    	headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    	headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    	headers['Access-Control-Max-Age'] = '1728000'
  	end
end
