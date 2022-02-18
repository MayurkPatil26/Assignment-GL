Feature: Singup Functionality On greatlearning

@signup
Scenario: Fill details and submit login/registration form
  Given I open "https://www.mygreatlearning.com/pg-program-cloud-computing-course/registration"
  Then Fill Basic Information
  Then Fill Professional Information
  Then Fill Education Information
  Then Fill Linkdine Information
  Then Fill Program demo Information
  Then Sign up
  Then close driver
  Then Print User Account Details
