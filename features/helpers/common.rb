require 'watir'

module Common

  # Sleep a short a time as possible to reduce testing time but prevent hanging 30 seconds
  def wait_for_element(element, title, exit = true)
    waited = 0
    [0.25, 0.5, 1, 2].each do |delay|
      return if element.exists?
      sleep(delay)
      waited += delay
    end
    fail("Waited for element #{title} for #{waited_for} seconds. Element not found.") if exit
  end

  # Standard delay for watching the test live
  def page_delay(seconds = ENV['MIN_PAGE_DELAY'].to_i)
    sleep(seconds) if ENV['DO_PAGE_DELAY'] == "true"
  end

  # Standard delay for clicking
  def click_delay(seconds = 0)
    sleep(ENV['MIN_CLICK_DELAY'].to_i + seconds) if ENV['DO_CLICK_DELAY'] == "true"
  end

  def click_link(name, type="text")
    if @browser.link(type.to_sym => "#{name}").exists?
      puts "Clicking on link #{name}"
      @browser.link(type.to_sym => "#{name}").click
    else
      fail("Link for #{name} not found")
    end
    click_delay
  end

  def click_button(name, type="text")
    if @browser.button(type.to_sym => "#{name}").exists?
      puts "Clicking on button #{name}"
      @browser.button(type.to_sym => "#{name}").click
    else
      fail("Button for #{name} not found")
    end
    click_delay
  end

  def click_element(element)
    element.click if element.exists?
  end

  def enter_element(element, value)
    if element.exists?
      element.set value
    else
      fail("Page element to set not found")
    end
  end

  def verify_text(text)
    unless @browser.text.include? text
      fail("Page does contain expected text: #{text}.")
    end
  end

  def verify_list_size(elements, count)
    found = elements.size
    fail("Expected count of #{count} but found #{found}") if found != count
  end
end
