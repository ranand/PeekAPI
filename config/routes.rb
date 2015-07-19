Rails.application.routes.draw do
  get "/api/timeslots" => "timeslots#index"
  post "/api/timeslots" => "timeslots#create"

  get "/api/boats" => "boats#index"
  post "/api/boats" => "boats#create"

  get "/api/assignments" => "assignments#index"
  post "/api/assignments" => "assignments#create"

  get "/api/bookings" => "bookings#index"
  post "/api/bookings" => "bookings#create"
end
