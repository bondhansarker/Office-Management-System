require 'rails_helper'
options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
driver = Selenium::WebDriver.for :firefox, options: options


RSpec.feature "Users", type: :feature do
  context "Create user" do
    it "should be successful" do
      login_as_admin(driver)
      driver.find_element(:css, "#user_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(6) > div > div > div > a:nth-child(1)").click
      driver.find_element(:css, "#employee_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(1) > div > div > div > a:nth-child(1)").click
      element = driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > h2").text
      element.eql? "Create a New User"
      driver.find_element(:css, "#user_email").send_keys("test@gmail.com")
      driver.find_element(:css, "#user_password").send_keys("111111")
      driver.find_element(:css, "#user_password_confirmation").send_keys("111111")
      driver.find_element(:css, "#user_name").send_keys("test user")
      driver.find_element(:css, "#user_phone").send_keys("000111")
      driver.find_element(:css, "#user_target_amount").send_keys(10000)
      driver.find_element(:css, "#user_bonus_percentage").send_keys(10)
      driver.find_element(:css, "#user_role").click
      driver.find_element(:css, "#user_role > option:nth-child(3)").click
      driver.find_element(:css, "#user_designation").click
      driver.find_element(:css, "#user_designation > option:nth-child(1)").click
      driver.find_element(:css, "input[type='submit']").click
      driver.current_url.eql? manage_users_url
      driver.find_element(:xpath, "/html/body/div[1]/div[2]/div[2]/table/tbody/tr[4]/td[6]/a[1]/i").click
      driver.navigate.back
      driver.find_element(:xpath, "/html/body/div[1]/div[2]/div[2]/table/tbody/tr[4]/td[6]/a[4]/i").click
      element = driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > h2").text
      element.eql? "Edit User Information"
      driver.find_element(:css, "#user_name").clear
      driver.find_element(:css, "#user_name").send_keys("test user edited")
      driver.find_element(:css, "input[type='submit']").click
      driver.find_element(:css, "#employee_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(1) > div > div > div > a:nth-child(2)").click
      driver.find_element(:xpath, "/html/body/div[1]/div[2]/div[2]/table/tbody/tr[4]/td[6]/a[5]/i").click
      driver.switch_to.alert.accept
      driver.find_element(:css, "#user_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(6) > div > div > div > a:nth-child(1)").click
      driver.switch_to.alert.accept
      logout_from_system(driver)
      driver.quit
    end
  end
end
