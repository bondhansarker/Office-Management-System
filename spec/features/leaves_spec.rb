require 'rails_helper'
driver = Selenium::WebDriver.for :firefox

RSpec.feature "Leaves", type: :feature do
  context "Appoint Leave" do
    it "should be successful" do
      login_as_admin(driver)
      driver.find_element(:css, "#leave_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(5) > div > div > div > a:nth-child(3)").click
      driver.find_element(:css, "h1").text.eql? "All Leave Requests"
      sleep(1)
      driver.find_element(:css, "#leave_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(5) > div > div > div > a:nth-child(2)").click
      driver.find_element(:css, "h1").text.eql? "List of Leave of Year : 2020"
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > div.table-responsive-sm > table > tbody > tr:nth-child(3) > td:nth-child(6) > a:nth-child(3) > i").click
      sleep(1)
      driver.switch_to.alert.accept
      sleep(1)

      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > a").click

      driver.find_element(:css, "h1").text.eql? "Allocate Leave"
      sleep(1)
      driver.find_element(:css, "#allocated_leafe_user_id > option:nth-child(2)").click
      sleep(1)
      driver.find_element(:css, "#allocated_leafe_year > option:nth-child(6)").click
      sleep(1)
      driver.find_element(:css, "#allocated_leafe_total_leave").send_keys(30)
      sleep(1)
      driver.find_element(css: "input[type='submit']").click
      sleep(1)
      logout_from_system(driver)
      sleep(2)
      puts driver.current_url
    end
  end

  context "Create new Leave" do
    it "should be successful" do
      login_as_employee(driver)
      driver.find_element(:css, "#leave_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(3) > div > div > div > a:nth-child(1)").click
      sleep(1.5)
      element = driver.find_element(:css, "h1").text
      "Apply for Leave".eql? element
      driver.find_element(:css, "#datepicker").send_keys(Date.today.beginning_of_week)
      sleep(1)
      driver.find_element(:css, "#datepicker2").send_keys(Date.today.at_beginning_of_week + 2.days)
      sleep(1)
      driver.find_element(:css, "#leafe_reason").send_keys("test reason")
      sleep(1)
      driver.find_element(:css, "#leafe_leave_type").send_keys("Training")
      sleep(1)
      driver.find_element(css: "input[type='submit']").click
      driver.current_url.eql? leaves_url
      sleep(1)
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(5) > a:nth-child(1) > i").click
      sleep(2)
      driver.navigate.back
      driver.current_url.eql? leaves_url
      sleep(1)
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(5) > a:nth-child(2) > i").click
      driver.find_element(:css, "h1").text.eql? "Edit"
      sleep(1)
      driver.find_element(:css, "#leafe_reason").send_keys("test reason edited")
      sleep(1)
      driver.find_element(css: "input[type='submit']").click
      driver.current_url.eql? leaves_url
      sleep(1)
      logout_from_system(driver)
      sleep(1)
    end
  end

  context "Approve leave" do
    it "should be successful" do
      login_as_admin(driver)
      driver.find_element(:css, "#leave_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(5) > div > div > div > a:nth-child(3)").click
      driver.find_element(:css, "h1").text.eql? "All Leave Requests"
      sleep(1)
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(5) > a:nth-child(1) > i").click
      sleep(1)
      driver.switch_to.alert.accept
      sleep(1)
      driver.find_element(:css, "h1").text.eql? "List of Leaves of Hemal"
      sleep(1)
      logout_from_system(driver)
      driver.quit
    end
  end

end
