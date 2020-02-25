module ApplicationHelper

  def convert_to_dhaka(datetime)
    datetime.in_time_zone('Dhaka')
  end

  def full_date(datetime)
    datetime = convert_to_dhaka(datetime)
    datetime.strftime('%d %B, %Y')
  end

  def full_date_with_time(datetime)
    datetime = convert_to_dhaka(datetime)
    datetime.strftime('%d %B, %Y at %I:%M %p')
  end

  def only_time(datetime)
    datetime = convert_to_dhaka(datetime)
    datetime.strftime('%I:%M %p')
  end

  def taka(amount)
    number_to_currency(amount, precision: 2, unit: " Taka", format: "%n %u")
  end

  def conversion(string)
    string.singularize()
    string.pluralize()
  end

  def budget_hint
    date = Date.today
    present_budget= Budget.find_by(month: date.month, year: date.year)
    if present_budget.nil?
      "The budget is not added yet !".html_safe
    else
      "Budget for  #{Date::MONTHNAMES[present_budget.month]}, #{present_budget.year}
      Total :   #{taka(present_budget.amount)}
      Expense :   #{taka(present_budget.expense)}
      Remaining :  #{taka(present_budget.amount - present_budget.expense)}".html_safe
    end
  end

  def see_pending_request
    pending =Expense.pending.count + Leafe.pending.count + Income.pending.count
    if pending > 0
      "<span class='badge'>
          #{pending}
      </span>".html_safe
    end
  end

  def check_in_out
    attendance = current_user.attendances
    attendance = attendance.where(date: Date.today.to_date).last
    if attendance.present? && attendance.status
      link_to ("Check Out <span class='status green'></span>").html_safe, attendance_path(attendance), method: :put, class: "dropdown-item", data: {confirm: "Are You Sure?"}
    else
      link_to ("Check In <span class='status red'></span>").html_safe, attendances_path, method: :post, class: "dropdown-item"
    end
  end

  def find_klass(income, target)
    if income > target
      return "bonusable"
    else
      return "not-bonusable"
    end
  end
end

