require 'watir'
require 'simplecov'
require 'dotenv'

Dotenv.load

SimpleCov.start if ENV["COVERAGE"] == "true"

#require 'page-object'
#require 'headless'

module SiteHelper

  def site( application = "cognify")
    get_site(application.downcase)
  end

  def browser
    site.browser
  end

  def get_site(application)
    return @site unless @site.nil? || (@site.application != application)
    @site = Object::const_get("#{application.capitalize}Site").new()
  end

  def save_screenshot
    filepath = "#{ENV['SCREENSHOT_DIR']}/screenhshot-#{Time.new.to_i}.png"
    browser.screenshot.save(filepath)
    embed("#{filepath}", "image/png")
  end
end

World(SiteHelper)

