# Author : Anand Ramakrishnan
# Date   : 07/18/2015

require 'PeekBooker'

class TimeslotsController < ApplicationController
	
	# We need these to help with CORS issue 
	skip_before_filter :verify_authenticity_token
  	before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers

  	# returns data when /api/timeslots GET is called.
	def index
		ts_arr = []
		timeslots = Timeslot.all
    	timeslots = timeslots.get_ts_data(params[:date])
      	timeslots.each do |object|
        	response_hash = PeekBooker.delete_timestaps(object)
        	response_hash["boats"] = object.boats.map(&:id)
        	object = response_hash
        	ts_arr << object
      	end

	    render json: ts_arr, status: 200
	end	

	# returns data when /api/timeslots POST is called.
	def create
		timeslot = Timeslot.new(timeslot_params)
		if timeslot.save
      		#PeekBooker.register_overlaping
      		render json: timeslot, status: 201
    	end
	end

	def show
	end

	def edit
	end

	def destroy
	end

	private

	# timeslot params that we need.
	def timeslot_params
		params.require(:timeslot).permit(:start_time, :duration, :availability, :customer_count)
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
