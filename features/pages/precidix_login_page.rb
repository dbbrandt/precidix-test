require 'watir'

module PrecidixLoginPageModule
  include WatirHelper
  include PrecidixCommon

  def tenant
    ENV['TEST_TENANT']
  end

  def password
    ENV['DEFAULT_PASSWORD']
  end

  # Assumes that environment is already (e.g. QA is arleady set in broswer)
  def login(username,title)

    open_page('login')

    @browser.text_field(:class => 'test-login-user-id').wait_until_present.click
    puts "Entering #{username} into user field"
    @browser.text_field(:class => 'test-login-user-id').set "#{username}"

    puts "Entering #{password} into password field"
    @browser.text_field(:class => 'test-login-password').set "#{password}"
    if @browser.text.include? 'Change Organization'
      @browser.a(:data_test_id => 'link-change-organization', :text => 'Change Organization').click
      click_delay
    end

    if @browser.text_field(:class => 'test-login-organization').exists?
      puts "Entering #{tenant} into organization field"
      enter_organization(tenant, 'organization')
    end

    click_delay
    @browser.send_keys :return
    page_delay
    verify_page?(title)
  end

  def enter_organization(value, field)
    if @browser.url.include? 'design'
      puts "Logging into ID WEB\n"
      @browser.text_field(:class => "ember-view ember-text-field form-control test-login-#{field}").set "#{value}"
    elsif @browser.url.include? 'learn'
      puts "Logging into Learn\n"
      @browser.text_field(:class => "test-login-#{field}").set value
    end
  end

    # Assumes that environment is already (e.g. QA is arleady set in broswer)
  def logout
    if verify_page?('login', false)
      return
    end

    puts "Logging out"
    img_class = (@site.application == "compose") ? "sl-gravatar" : "profilePic"
    @browser.img(:class => img_class).click #Ember navigation
    click_delay
    @browser.link(:text =>"Log Out").click
    page_delay
    verify_page?('login')
  end
end

class PrecidixLoginPage
  prepend SiteContainer
  include PrecidixLoginPageModule
end
