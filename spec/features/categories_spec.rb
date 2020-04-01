require 'rails_helper'
options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
driver = Selenium::WebDriver.for :firefox, options: options

RSpec.feature "Category", type: :feature do

  context "Category" do
    it "should be successful" do
      login_as_admin(driver)
      driver.manage().window().maximize()
      driver.find_element(:css, "#budget_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(4)").click
      expect(driver.current_url).to eq("http://localhost:3000#{budgets_path}")
      driver.find_element(:css, "#budget_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(1)").click
      expect(driver.find_element(:css, "h1").text).to eq("Insert Budget Information")
      driver.find_element(:css, ".btn-success").click
      driver.find_element(:css, "#budget_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(3)").click
      driver.find_element(:css, "#budget_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(2)").click
      driver.find_element(:css, "#category_name").send_keys("Category 1")
      driver.find_element(:css, ".btn-success").click
      driver.find_element(:css, "#budget_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(2)").click
      driver.find_element(:css, "#category_name").send_keys("Category")
      driver.find_element(:css, ".btn-success").click
      driver.find_element(:css, "#budget_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(2) > div > div > div > a:nth-child(2)").click
      driver.find_element(:css, "#category_name").send_keys("Delete")
      driver.find_element(:css, ".btn-success").click
    end
  end

  context "Delete Category" do
    it "should be successful" do
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > div.table-responsive-sm > table > tbody > tr:nth-child(3) > td:nth-child(3) > a:nth-child(2)").click
      driver.switch_to.alert.accept
    end
  end

  context "Edit" do
    it "should be successful" do
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > div.table-responsive-sm > table > tbody > tr:nth-child(2) > td:nth-child(3) > a:nth-child(1)").click
      driver.find_element(:css, "#category_name").send_keys(" 2")
      driver.find_element(:css, ".btn-success").click
    end
  end
end