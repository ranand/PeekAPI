# Author : Anand Ramakrishnan
# Date   : 07/18/2015

class BoatsController < ApplicationController

	# We need these to help with CORS issue 
	skip_before_filter :verify_authenticity_token
  	before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers
	
	# returns data when /api/boats GET is called.
	def index
		boats = Boat.all
    	render json: boats, status: 200
	end	

	# saves data when /api/boats POST is called.
	def create
		boat = Boat.new(boat_params)
    	if boat.save
      		render json: boat, status: 201
    	end
	end

	def show
	end

	def edit
	end

	def destroy
	end

	private

	# Boat params that we need.
	def boat_params
		params.require(:boat).permit(:capacity, :name)
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
