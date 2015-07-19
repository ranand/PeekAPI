# Author : Anand Ramakrishnan
# Date   : 07/18/2015

require 'PeekBooker'

class AssignmentsController < ApplicationController
	
	# We need these to help with CORS issue 	
	skip_before_filter :verify_authenticity_token
  	before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers

  	# returns data when /api/assignments GET is called.
	def index
		boats = Assignment.all
    	render json: boats, status: 200
	end	

	# saves data when /api/assignments POST is called.
	def create
		assignment = Assignment.new(assignment_params)
	    if assignment.save
	    	# Mark the boat as used.
	    	puts "before assign_boat"
	    	PeekBooker.assign_boat(assignment.boat_id)
	    	puts "after assign_boat"
	    	# Update the boat's data (availability/status)
	      	PeekBooker.upd_boat_status(assignment.timeslot_id)
	      	render json: assignment, status: 201
	    end
	end

	def show
	end

	def edit
	end

	def destroy
	end

	private

	# basic params we need to work with.
	def assignment_params
		params.require(:assignment).permit(:timeslot_id, :boat_id)
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
