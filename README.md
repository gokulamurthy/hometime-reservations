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

Api::V1::ReservationsController<br/>
&nbsp;&nbsp;&nbsp;&nbsp;POST #create<br/>
    when payload type is A<br/>
&nbsp;&nbsp;&nbsp;&nbsp;creates a reservation with normalized valid payload<br/>
&nbsp;&nbsp;&nbsp;&nbsp;returns an error when end date is greater than start date<br/>
    when payload type is B<br/>
&nbsp;&nbsp;&nbsp;&nbsp;creates a reservation with normalized payload<br/>
&nbsp;&nbsp;&nbsp;&nbsp;returns an error when end date is lesser than start date<br/>
    when payload type is invalid<br/>
&nbsp;&nbsp;&nbsp;&nbsp;returns an error response<br/>
  PATCH #update<br/>
    when reservation exists<br/>
&nbsp;&nbsp;&nbsp;&nbsp;updates the reservation<br/>
    when reservation does not exist<br/>
&nbsp;&nbsp;&nbsp;&nbsp;returns an error<br/>
<br/><br/>
Finished in 0.18599 seconds (files took 3.53 seconds to load)<br/>
7 examples, 0 failures
