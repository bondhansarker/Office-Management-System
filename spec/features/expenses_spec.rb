require 'rails_helper'
driver = Selenium::WebDriver.for :firefox

RSpec.feature "Expense", type: :feature do

  before(:each) do
    login_as_employee(driver)
  end

  context "Expense" do
    it "should be successful" do
      driver.manage().window().maximize()
      sleep(1)
      driver.find_element(:css, "#expnese_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(1) > div > div > div > a:nth-child(2)").click
      sleep(1)
      driver.find_element(:css, "#expnese_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(1) > div > div > div > a:nth-child(1)").click
      sleep(1)
      driver.find_element(:css, "#expense_product_name").send_keys("Test expense")
      driver.find_element(:css, "#expense_category_id").click
      driver.find_element(:css, "#expense_category_id > option:nth-child(1)").click
      sleep(1)
      driver.find_element(:css, "#expense_cost").send_keys("100")
      driver.find_element(:css, "#expense_details").send_keys("Running test")
      driver.find_element(:css, "#datepicker").send_keys("2020-03-21")
      sleep(1)
      driver.find_element(css: "input[type='submit']").click
      sleep(1)
      driver.find_element(css: ".fa-eye").click
      sleep(1)
      driver.find_element(css: ".btn-dark").click
      sleep(1)
      driver.find_element(css: ".fa-trash").click
      sleep(1)
      driver.switch_to().alert().accept()
      sleep(1)
      driver.find_element(:css, "#expnese_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(1) > div > div > div > a:nth-child(1)").click
      sleep(1)
      driver.find_element(:css, "#expense_product_name").send_keys("Test expense")
      driver.find_element(:css, "#expense_category_id").click
      driver.find_element(:css, "#expense_category_id > option:nth-child(1)").click
      sleep(1)
      driver.find_element(:css, "#expense_cost").send_keys("100")
      driver.find_element(:css, "#expense_details").send_keys("Running test")
      driver.find_element(:css, "#datepicker").send_keys("2020-03-21")
      sleep(1)
      driver.find_element(css: "input[type='submit']").click
      sleep(1)
      driver.find_element(css: ".fa-eye").click
      sleep(1)
      driver.find_element(css: ".btn-dark").click
      sleep(1)
      driver.find_element(css: ".fa-edit").click
      sleep(1)
      driver.find_element(:css, "#expense_product_name").send_keys(" Edited ")
      sleep(1)
      driver.find_element(css: "input[type='submit']").click
      sleep(1)
      driver.quit
    end
  end
end
