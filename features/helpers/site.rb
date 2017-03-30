require 'watir'
require 'page-object'

module SiteContainer
  include PageObject

  # Initialize the PageObject with the browser as well as provide access to the site.
  def initialize(browser, site)
    @site = site
    super browser
  end

  def site
    return @site
  end

end

class Site
  attr_accessor :application, :browser, :scenario, :feature, :failed

  def environment
    ENV['TEST_ENV']
  end

  def initialize
    @browser = Watir::Browser.new :chrome
    # open browser on base URL
    puts "Open #{@application}"
    goto("/")
  end

  def goto(path)
    puts "Goto #{base_url+path}"
    @browser.goto base_url+path
  end

  def close
    puts "Close Browser"
    puts("===============")
    if @failed
      puts "Scenario Failed: #{@scenario}!"
    else
      puts "Scenario Succeeded: #{@scenario}!"
    end
    puts "Ending Scenario"
    puts("===============")
    @browser.close
  end
end
