module Helper


  def login_as_super_admin(driver)
    driver.get("http://localhost:3000")
    driver.find_element(:css, "#user_email").send_keys("admin@rightcodes.org")
    driver.find_element(:css, "#user_password").send_keys("111111")
    driver.find_element(css: "input[type='submit']").click
    element = driver.find_element(:css, "h3").text
    "Super Admin's Dashboard".eql? element
    sleep(2)
    driver.find_element(:css, "#user_menu").click
    sleep(0.5)
    driver.find_element(:css, "#logout").click
  end

  def login_as_admin(driver)
    #driver = Selenium::WebDriver.for :firefox
    driver.get("http://localhost:3000")
    driver.find_element(:css, "#user_email").send_keys("shariful.alam85@gmail.com")
    driver.find_element(:css, "#user_password").send_keys("111111")
    driver.find_element(css: "input[type='submit']").click
    element = driver.find_element(:css, "h3").text
    "Admin's Dashboard".eql? element
    sleep(2)
    driver.find_element(:css, "#user_menu").click
    sleep(0.5)
    driver.find_element(:css, "#logout").click
  end

  def login_as_employee(driver)
    #driver = Selenium::WebDriver.for :firefox
    driver.get("http://localhost:3000")
    driver.find_element(:css, "#user_email").send_keys("shariful.alam@rightcodes.org")
    driver.find_element(:css, "#user_password").send_keys("111111")
    driver.find_element(css: "input[type='submit']").click
    element = driver.find_element(:css, "h3").text
    "Employee's Dashboard".eql? element
    sleep(2)
    driver.find_element(:css, "#user_menu").click
    sleep(0.5)
    driver.find_element(:css, "#logout").click
  end

end
