require 'rails_helper'
options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
driver = Selenium::WebDriver.for :firefox, options: options


RSpec.feature "Incomes", type: :feature do
  context "Admin's income" do
    it "should be be successful" do
      driver.manage.window.maximize
      login_as_admin(driver)
      driver.find_element(:css, "#income_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(4) > div > div > div > a:nth-child(1)").click
      driver.find_element(:css, "h1").text.eql? "Add Income"
      driver.find_element(:css, "#income_amount").send_keys(1000)
      driver.find_element(:css, "#datepicker").send_keys Date.today.beginning_of_week, :return
      sleep(1)
      driver.find_element(:css, "#income_source").click
      driver.find_element(:css, "#income_source > option:nth-child(1)").click
      driver.find_element(css: "input[type='submit']").click
      driver.current_url.eql? incomes_url
      driver.find_element(:css, "#income > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(1) > a").click
      driver.find_element(:css, "h1").text.eql? "All Income List of Shariful Alam of year 2020"
      element = driver.current_url
      driver.find_element(:css, "#approved > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(5) > a:nth-child(1) > i").click
      driver.switch_to.alert.accept
      driver.current_url.eql? element
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-warning").click
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(5) > a:nth-child(3) > i").click
      driver.find_element(:css, "h1").text.eql? "Details of Income"
      driver.navigate.back
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-warning").click
      element = driver.current_url
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(5) > a:nth-child(4) > i").click
      driver.find_element(:css, "h1").text.eql? "Edit"
      driver.find_element(:css, "#income_amount").clear
      driver.find_element(:css, "#income_amount").send_keys(100000)
      driver.find_element(css: "input[type='submit']").click
      driver.current_url.eql? element
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-warning").click
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(5) > a:nth-child(1) > i").click
      driver.switch_to.alert.accept
      driver.current_url.eql? element
      driver.find_element(:css, "#income_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(4) > div > div > div > a:nth-child(2)").click
      driver.find_element(:css, "#income > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(4) > a").click
      element = driver.find_element(:css, "h2").text
      element.eql? "Hurrah!! Shariful Alam is getting 9,000.00 Taka BONUS!!"
      driver.find_element(:css, "#approved > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(5) > a:nth-child(1) > i").click
      driver.switch_to.alert.accept
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-warning").click
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(5) > a:nth-child(5) > i").click
      driver.switch_to.alert.accept
      logout_from_system(driver)
    end
  end

  context "Employee's income" do
    it "should be successful" do
      login_as_employee(driver)
      driver.find_element(:css, "#income_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(1)").click
      driver.find_element(:css, "h1").text.eql? "Add Income"
      driver.find_element(:css, "#income_amount").send_keys(1000)
      driver.find_element(:css, "#datepicker").send_keys Date.today.beginning_of_week, :return
      driver.find_element(:css, "#income_source").click
      driver.find_element(:css, "#income_source > option:nth-child(1)").click
      driver.find_element(css: "input[type='submit']").click
      element = driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > h1").text
      element.eql? "All Income List of Hemal"
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-warning").click
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(5) > a:nth-child(1) > i").click
      driver.navigate.back
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-warning").click
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(5) > a:nth-child(2) > i").click
      sleep(1)
      driver.find_element(:css, "#income_amount").clear
      sleep(1)
      driver.find_element(:css, "#income_amount").send_keys(100000)
      sleep(1)
      driver.find_element(css: "input[type='submit']").click
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-warning").click
      sleep(1)
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(5) > a:nth-child(3) > i").click
      sleep(1)
      driver.switch_to.alert.accept
      sleep(1)
      logout_from_system(driver)
      driver.quit
    end
  end
end
