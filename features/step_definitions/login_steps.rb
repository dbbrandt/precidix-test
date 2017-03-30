When(/^I am on the (.+?) website$/i) do |website|
  site(website)
end

Then(/^I login as (.+?) to (.+?) page$/) do |username,title|
  site.login_page.login(username,title)
end

When(/^I am not logged in$/i) do
  site.login_page.logout
end
