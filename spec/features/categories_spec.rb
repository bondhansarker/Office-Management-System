require 'rails_helper'
driver = Selenium::WebDriver.for :firefox

RSpec.feature "Category", type: :feature do

  context "Category" do
    it "should be successful" do
      login_as_admin(driver)
      driver.manage().window().maximize()
      sleep(1)
      driver.find_element(:css, "#budget_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(4)").click
      sleep(1)
      expect(driver.current_url).to eq("http://localhost:3000#{budgets_path}")
      sleep(1)
      driver.find_element(:css, "#budget_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(1)").click
      sleep(1)
      expect(driver.find_element(:css, "h1").text).to eq("Insert Budget Information")
      driver.find_element(:css, ".btn-success").click
      sleep(1)
      driver.find_element(:css, "#budget_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(3)").click
      sleep(1)
      driver.find_element(:css, "#budget_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(2)").click
      sleep(1)
      driver.find_element(:css, "#category_name").send_keys("Category 1")
      sleep(1)
      driver.find_element(:css, ".btn-success").click
      sleep(1)
      driver.find_element(:css, "#budget_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(2)").click
      sleep(1)
      driver.find_element(:css, "#category_name").send_keys("Category")
      sleep(1)
      driver.find_element(:css, ".btn-success").click
      sleep(1)
      driver.find_element(:css, "#budget_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(2)").click
      sleep(1)
      driver.find_element(:css, "#category_name").send_keys("Delete")
      sleep(1)
      driver.find_element(:css, ".btn-success").click
      sleep(1)
    end
  end

  context "Delete Category" do
    it "should be successful" do
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > div.table-responsive-sm > table > tbody > tr:nth-child(3) > td:nth-child(3) > a:nth-child(2)").click
      sleep(1)
      driver.switch_to.alert.accept
      sleep(1)
    end
  end

  context "Edit" do
    it "should be successful" do
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(3) > a:nth-child(1)").click
      sleep(1)
      driver.find_element(:css, "#category_name").send_keys(" 2")
      sleep(1)
      driver.find_element(:css, ".btn-success").click
      sleep(1)
    end
  end
end