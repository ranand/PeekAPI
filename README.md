== README

This is a RoR project for the Peek API challenge. 

Make sure to run
----------------
* rake db:migrate 
* rails s
* Run npm start on passport project and visit localhost:3333 and play around. 


DB Schema:
----------
* timeslot_id, booking_id are foreign keys to assignments table
* timeslot_id is foreign key to bookings table



Few gotchas
-----------
* No test suite is present as of this commit.
* I used postman for several tests and responses


API suggestions
---------------


Complications
-------------
* Maintaining record of whether a boat is booked for a specific timeslot was little tough to work with. Seperation of concerns is the best way to scale. And I think this DB model did suggest that.
* The API can be scaled (I'm sure it is present already in the main version) to check number of travelers against timeslot and remove that timeslot from selection if the number of travelers exceed.
* Routes can be organized in a better manner with namespaces and scopes.
* Joining data over a few tables is ok, but will it scale for various purposes with consistent performance is a question.
