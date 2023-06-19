# HOMETIME RESERVATIONS SYSTEM

This application allows to integrate different API payloads into a single reservation system with normalized data structure. Please follow the below instructions to install and run:

Application has built with

- Ruby version : 2.7.4
- Rails version : 6.1.7.3
- Database : Sqlite

**Configuration**

- System Dependencies

Run the below commands to install the application dependencies from the application root folder.

`bundle install`

- Database creation

`rails db:migrate`

- How to run the test suite

`rspec -fd`

**Test Results**

Api::V1::ReservationsController
POST #create
when payload type is A
creates a reservation with normalized valid payload
returns an error when end date is greater than start date
when payload type is B
creates a reservation with normalized payload
returns an error when end date is lesser than start date
when payload type is invalid
returns an error response
PATCH #update
when reservation exists
updates the reservation
when reservation does not exist
returns an error

Finished in 0.18599 seconds (files took 3.53 seconds to load)
7 examples, 0 failures
