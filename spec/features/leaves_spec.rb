require 'rails_helper'
driver = Selenium::WebDriver.for :firefox

RSpec.feature "Leaves", type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    @allocated_leafe = FactoryBot.create(:allocated_leafe, user: @user)
    @leafe = FactoryBot.create(:leafe, user: @user)
    login_as_admin(driver)
  end

  context "Create new Leave" do
    it "should be successful" do
      driver.find_element(:css, "#leave_menu").click
      driver.find_element(:css, "#new_leave").click
      sleep(1.5)
      element = driver.find_element(:css, "h1").text
      "Apply for Leave".eql? element
      driver.find_element(:css, "#datepicker").send_keys(@leafe.start_date)
      sleep(1)
      driver.find_element(:css, "#datepicker2").send_keys(@leafe.end_date)
      sleep(1)
      driver.find_element(:css, "#reason").send_keys(@leafe.reason)
      sleep(1)
      driver.find_element(:css, "#leafe_leave_type").send_keys(@leafe.leave_type)
      sleep(1)
      driver.find_element(css: "input[type='submit']").click
      driver.current_url.eql? leaves_url
      driver.find_element(:css, "h1").text.eql? "All Leave Requests"
      sleep(1)
      logout(driver)
    end

  end

end
