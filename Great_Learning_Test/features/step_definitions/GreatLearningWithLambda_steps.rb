Given("I open {string}") do |url|
  @greatlearning_page = GreatlearningPage.new
  @greatlearning_page.open_greatlearning(url)
end

Then(/^Fill Basic Information$/) do
  @greatlearning_page.fill_basic_info
end

Then(/^Fill Professional Information$/) do
  @greatlearning_page.fill_professional_details
end

Then(/^Fill Education Information$/) do
  @greatlearning_page.fill_education_details
end

Then(/^Fill Linkdine Information$/) do
  @greatlearning_page.fill_linkdine_details
end

Then(/^Fill Program demo Information$/) do
  @greatlearning_page.fill_program_demo
end

Then(/^Sign up$/) do
  @greatlearning_page.do_signup
end

Then(/^Print User Account Details$/) do  
  @greatlearning_page.print_user_account_details
end

Then(/^close driver$/) do
  @greatlearning_page.close_the_browser
end
