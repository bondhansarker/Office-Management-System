require 'rails_helper'
driver = Selenium::WebDriver.for :firefox
#/html/body/div[1]/div[2]/div[2]/table/tbody/tr[3]/td[6]/a[1]/i


RSpec.feature "Users", type: :feature do
  context "Create user" do
    it "should be successful" do
      login_as_admin(driver)
      #commented out lines for check in/out
=begin
      driver.find_element(:css, "#user_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(6) > div > div > div > a:nth-child(1)").click
      sleep(1)
=end
      driver.find_element(:css, "#employee_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(1) > div > div > div > a:nth-child(1)").click
      element = driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > h2").text
      element.eql? "Create a New User"
      sleep(1)
      driver.find_element(:css, "#user_email").send_keys("test@gmail.com")
      sleep(1)
      driver.find_element(:css, "#user_password").send_keys("111111")
      sleep(1)
      driver.find_element(:css, "#user_password_confirmation").send_keys("111111")
      sleep(1)
      driver.find_element(:css, "#user_name").send_keys("test user")
      sleep(1)
      driver.find_element(:css, "#user_phone").send_keys("000111")
      sleep(1)
      driver.find_element(:css, "#user_target_amount").send_keys(10000)
      sleep(1)
      driver.find_element(:css, "#user_bonus_percentage").send_keys(10)
      sleep(1)
      driver.find_element(:css, "#user_role").click
      sleep(1)
      driver.find_element(:css, "#user_role > option:nth-child(3)").click
      sleep(1)
      driver.find_element(:css, "#user_designation").click
      sleep(1)
      driver.find_element(:css, "#user_designation > option:nth-child(1)").click
      sleep(1)
      driver.find_element(:css, "input[type='submit']").click
      sleep(1)
      driver.current_url.eql? manage_users_url
      sleep(1)
      driver.find_element(:xpath, "/html/body/div[1]/div[2]/div[2]/table/tbody/tr[4]/td[6]/a[1]/i").click
      sleep(1)
      driver.navigate.back
      sleep(1)
      driver.find_element(:xpath, "/html/body/div[1]/div[2]/div[2]/table/tbody/tr[4]/td[6]/a[4]/i").click
      element = driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > h2").text
      element.eql? "Edit User Information"
      sleep(1)
      driver.find_element(:css, "#user_name").clear
      sleep(1)
      driver.find_element(:css, "#user_name").send_keys("test user edited")
      sleep(1)
      driver.find_element(:css, "input[type='submit']").click
      sleep(1)
      driver.find_element(:css, "#employee_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(1) > div > div > div > a:nth-child(2)").click
      sleep(1)
      driver.find_element(:xpath, "/html/body/div[1]/div[2]/div[2]/table/tbody/tr[4]/td[6]/a[5]/i").click
      sleep(1)
      driver.switch_to.alert.accept
      sleep(1)
=begin
      driver.find_element(:css, "#user_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(6) > div > div > div > a:nth-child(1)").click
      sleep(1)
      driver.switch_to.alert.accept
      sleep(1)
=end
      logout_from_system(driver)

      driver.quit
    end
  end
end
