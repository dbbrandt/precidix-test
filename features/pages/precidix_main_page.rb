require 'watir'

module PrecidixMainPageModule
  include WatirHelper
  include PrecidixCommon


  def coach_click_student(student)
    puts "Clicking on student #{student}"
    click_element(@browser.span(:class => "userProfile-username", :text => student ))
    click_delay
  end

  def coach_search_students(query)
    puts "Searching for students by #{query}"
    enter_element(@browser.text_field(:type => "text", :class => "filterableListPage--topSearch"), query)
    click_delay(1)
  end

  def click_account
    @browser.img(:class => "profilePic").click
    click_delay
  end

  def coach_filter_students(filter)
    puts "Filtering students by #{filter}"
    @browser.span(:class => "filterableListPage--filterListText", :text => filter).click
    click_delay(1)
  end

  def verify_student_count(count)
    puts "Verifying student list conatins #{count} students"
    verify_list_size(@browser.sections(:class => "tasksList-item filterableListPage--card"),count.to_i)
  end

  def  click_announcement(text)
    click_link("announcement-unread-bell","class") if text == "bell"
    click_button("announcementIcon","class") if text == "horn"
  end

  def post_announcement(role,type)
     #this side effect variable @input_date is used to verify the next view can find the same announcement
     @input_date = Time.now.strftime("%m/%d/%Y %H:%M")

     @browser.select(:class => "announcement--selectStyle").select(type)
     @browser.text_field(:class => 'announcementSubjectInput').set "#{role}-#{type}-#{@input_date}-subject"
     @browser.textarea(:class => 'announcementBodyInput').set "#{role}-#{type}-#{@input_date}-body"

     click_button("announcementSubmitButton","class")
  end

  def coach_view_announcement(role,type)
    verify_text("Announcement History")
    verify_text(role)
    verify_text(type)
  end

  def student_view_announcement(role,type)
    verify_text("Announcement History")
    verify_text(role)
    verify_text(type)
    verify_text("#{role}-#{type}-#{@input_date}-subject")
    verify_text("#{role}-#{type}-#{@input_date}-body")
  end
end

class PrecidixMainPage
  prepend SiteContainer
  include PrecidixMainPageModule
end
