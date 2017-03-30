When /^I am on the (.+?) page$/ do |page|
  site.main_page.open_page(page)
end

Then /^I goto the (.+?) page$/ do |page|
  site.main_page.verify_page?(page)
end

And(/^I see (.*)$/) do |value|
  site.main_page.verify_text(value)
end

