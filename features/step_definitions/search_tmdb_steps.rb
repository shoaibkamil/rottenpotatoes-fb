Then /^I should see the search form$/ do
  Then "I should see \"Input Movie Title\""
  response.should have_xpath("//input[@type='text' and @id='title']")
end

When /^I select the first result$/ do
  within("table tr:nth-child(2)") do |scope|
  	scope.click_button "Select"
  end
end