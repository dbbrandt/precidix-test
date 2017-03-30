
Before do
  #@browser = Watir::Browser.new
  #$driver = Selenium::WebDriver.for :firefox
end

After do
  site.close
end


After do | scenario|
  site.scenario = scenario.source[1].to_s
  site.feature  = scenario.source[0].to_s
  site.failed = scenario.failed?
  save_screenshot if scenario.failed?
end