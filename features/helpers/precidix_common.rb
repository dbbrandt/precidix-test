require 'watir'
require_relative 'common'

module PrecidixCommon
  include Common

  # Assumes a browser is already established
  def open_page(key)
    return if verify_page?(key, false)
    site.goto(site.get_path(key))
    page_delay
    verify_page?(key)
  end

  # Check to see if the page title matches the desired result
  def verify_page?(key, exit = true)
    base_title = wait_for_title(exit)
    puts "Verify Title - Desired Prefix: #{site.get_title(key)} => Full Title: #{page_title}" if exit
    if site.get_title(key) != base_title
      fail("Page title does not match expected result. EXPECTED: #{site.get_title(key)} FOUND: #{page_title}") if exit
      return false
    end
    return true
  end

  # TODO replace with a better way to verify the page rather than wait for the title to populate
  # It has the default value until an asynchronus task updates it for the page name
  # Page titles include a unique prefix followed by "-" and a standard suffix.
  # Sleep a short a time as possible to reduce testing time prevent hanging 30 seconds
  def wait_for_title(exit)
    waited = 0
    [0.25, 0.5, 1, 2, 4, 8, 16].each do |delay|
      if page_title =~ /-/
        title = page_title.gsub(/[-].+/, '').strip
        unless title.empty?
          puts "Waited for page title for #{waited} seconds."
          return title
        end
      end
      sleep(delay)
      waited += delay
    end
    fail("Waited for page title for #{waited} seconds. Page title not found.") if exit
  end
end
