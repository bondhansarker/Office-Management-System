module Helper


  def login_as_super_admin(driver)
    driver.get("http://localhost:3000")
    driver.find_element(:css, "#user_email").send_keys("admin@rightcodes.org")
    driver.find_element(:css, "#user_password").send_keys("111111")
    driver.find_element(css: "input[type='submit']").click
    element = driver.find_element(:css, "h3").text
    "Super Admin's Dashboard".eql? element
  end

  def login_as_admin(driver)
    driver.get("http://localhost:3000")
    driver.find_element(:css, "#user_email").send_keys("shariful.alam85@gmail.com")
    driver.find_element(:css, "#user_password").send_keys("111111")
    driver.find_element(css: "input[type='submit']").click
    element = driver.find_element(:css, "h3").text
    "Admin's Dashboard".eql? element
  end

  def login_as_employee(driver)
    driver.get("http://localhost:3000")
    driver.find_element(:css, "#user_email").send_keys("shariful.alam@rightcodes.org")
    driver.find_element(:css, "#user_password").send_keys("111111")
    driver.find_element(css: "input[type='submit']").click
    element = driver.find_element(:css, "h3").text
    "Employee's Dashboard".eql? element
  end

  def logout_from_system(driver)
    driver.find_element(:css, "#user_menu").click
    driver.find_element(:css, "#logout").click
  end

  def create_expense(driver,name,month)
    driver.find_element(:css, "#expnese_menu").click
    driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(1) > div > div > div > a:nth-child(1)").click
    driver.current_url.eql? new_expense_url
    driver.find_element(:css, "h1").text.eql? "Insert Expense Information"
    driver.find_element(:css, "#expense_product_name").send_keys("#{name}")
    driver.find_element(:css, "#expense_category_id").click
    driver.find_element(:css, "#expense_category_id > option:nth-child(2)").click
    driver.find_element(:css, "#expense_cost").send_keys("100")
    driver.find_element(:css, "#expense_details").send_keys("Running test")
    driver.find_element(:css, "#datepicker").send_keys("2020-#{month}-21")
    driver.find_element(css: "input[type='submit']").click
  end


end
