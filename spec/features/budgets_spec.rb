require 'rails_helper'
driver = Selenium::WebDriver.for :firefox

RSpec.feature "Budget", type: :feature do

  context "Create present month" do
    it "should be successful" do
      login_as_admin(driver)
      driver.manage().window().maximize()
      hover_selector = driver.find_element(:css, "#budget_menu")
      driver.action.move_to(hover_selector).perform
      sleep(5)
      driver.find_element(:css, "#budget_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(1)").click
      sleep(1)
      expect(driver.find_element(:css, "h1").text).to eq("Insert Budget Information")
      driver.find_element(:css, "#budget_month").click
      sleep(1)
      driver.find_element(:css, "#budget_month > option:nth-child(4)").click
      sleep(1)
      driver.find_element(:css, "#budget_category_id").click
      sleep(1)
      driver.find_element(:css, "#budget_category_id > option:nth-child(1)").click
      sleep(1)
      driver.find_element(:css, "#budget_amount").send_keys("10000")
      sleep(1)
      driver.find_element(:css, ".btn-success").click
      sleep(1)
      hover_selector = driver.find_element(:css, "#budget_menu > strong")
      driver.action.move_to(hover_selector).perform
      sleep(5)
    end
  end

  context "Create" do
    it "should be successful" do
      driver.find_element(:css, "#budget_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(1)").click
      sleep(1)
      expect(driver.find_element(:css, "h1").text).to eq("Insert Budget Information")
      driver.find_element(:css, "#budget_month").click
      sleep(1)
      driver.find_element(:css, "#budget_month > option:nth-child(3)").click
      sleep(1)
      driver.find_element(:css, "#budget_category_id").click
      sleep(1)
      driver.find_element(:css, "#budget_category_id > option:nth-child(2)").click
      sleep(1)
      driver.find_element(:css, "#budget_amount").send_keys("10000")
      sleep(1)
      driver.find_element(:css, ".btn-success").click
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > div.table-responsive-sm > table > tbody > tr > td:nth-child(2) > a").click
      sleep(1)
      driver.find_element(:css, "#budget_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(1)").click
      sleep(1)
      expect(driver.find_element(:css, "h1").text).to eq("Insert Budget Information")
      driver.find_element(:css, "#budget_month").click
      sleep(1)
      driver.find_element(:css, "#budget_month > option:nth-child(3)").click
      sleep(1)
      driver.find_element(:css, "#budget_category_id").click
      sleep(1)
      driver.find_element(:css, "#budget_category_id > option:nth-child(1)").click
      sleep(1)
      driver.find_element(:css, "#budget_amount").send_keys("10000")
      sleep(1)
      driver.find_element(:css, ".btn-success").click
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > div.table-responsive-sm > table > tbody > tr > td:nth-child(2) > a").click
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(5) > a:nth-child(1)").click
      sleep(1)
      driver.find_element(:css, "#budget_add").send_keys("5000")
      sleep(1)
      driver.find_element(:css, ".btn-success").click
      sleep(1)
      driver.find_element(:css, ".btn-dark").click
      sleep(2)
      driver.quit
    end
  end
end