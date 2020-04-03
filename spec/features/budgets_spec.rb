require 'rails_helper'

RSpec.feature "Budget", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    @budget = FactoryBot.create(:budget, user: @user, category: @category)
    login_as(@user, :scope => :user)
  end

  describe "Create" do
    it "should be successful" do
      category1 = FactoryBot.build(:category)
      category1.name = "Category 1"
      category1.save
      visit(root_url)
      click_on 'Budget'
      click_on 'Add new budget'
      expect(current_url).to eq(new_budget_url)
      expect(find(:css, "h1").text).to eq("Insert Budget Information")
      within('form') do
        find('#budget_year').find(:xpath, 'option[1]').select_option
        find('#budget_month').find(:xpath, 'option[1]').select_option
        find('#budget_category_id').find(:xpath, 'option[2]').select_option
        fill_in 'budget_amount', with: '10000'
      end
      click_on 'Submit'
      expect(page).to have_content("Budget has been created successfully!!")
      expect(current_url).to eq(budgets_url)
      expect(find(:css, "h1").text).to eq("Budget List for #{Date.today.year}")
      expect(page).to have_content(@budget.month)
    end
  end

  describe "Show" do
    context "all budgets of a month" do
      it "should be successful" do
        visit(budgets_url)
        expect(current_url).to eq(budgets_url)
        expect(find(:css, "h1").text).to eq("Budget List for #{Date.today.year}")
        expect(page).to have_content(@budget.month)
        within('.table') do
          page.find('.show_budgets_link').click
        end
        expect(current_url).to eq("#{show_all_budgets_url}?month=#{@budget.month}&year=#{@budget.year}")
        expect(find(:css, "h1").text).to eq("All Budgets for #{Date::MONTHNAMES[@budget.month]}, #{@budget.year}")
      end
    end

    context "all expenses of a month" do
      it "should be successful" do
        @expense = FactoryBot.create(:expense, user: @user, category: @category)
        visit(budgets_url)
        expect(current_url).to eq(budgets_url)
        expect(find(:css, "h1").text).to eq("Budget List for #{Date.today.year}")
        expect(page).to have_content(@budget.month)
        within('.table') do
          page.find('.show_expenses_link').click
        end
        expect(current_url).to eq("#{show_all_expenses_budgets_url}?month=#{@budget.month}&year=#{@budget.year}")
        expect(find(:css, "h3").text).to eq("Expenses of #{Date::MONTHNAMES[@budget.month]}, #{@budget.year}")
        expect(1).to eq(Expense.approved.count)
        expect(page).to have_content("Approved (#{Expense.approved.count})")
        expect(page).to have_content("Pending (#{Expense.pending.count})")
        expect(page).to have_content("Pending (#{Expense.rejected.count})")
      end
    end
  end

  context "Destroy" do
    it "should be successful" do
      visit(budgets_url)
      expect(current_url).to eq(budgets_url)
      expect(find(:css, "h1").text).to eq("Budget List for #{Date.today.year}")
      expect(page).to have_content(@budget.month)
      within('.table') do
        page.find('.show_budgets_link').click
      end
      expect(current_url).to eq("#{show_all_budgets_url}?month=#{@budget.month}&year=#{@budget.year}")
      expect(find(:css, "h1").text).to eq("All Budgets for #{Date::MONTHNAMES[@budget.month]}, #{@budget.year}")
      within('.table') do
        page.find('.destroy_link').click
      end
      expect(current_url).to eq("#{show_all_budgets_url}?month=#{@budget.month}&year=#{@budget.year}")
      expect(find(:css, "h1").text).to eq("All Budgets for #{Date::MONTHNAMES[@budget.month]}, #{@budget.year}")
      expect(0).to eq(Budget.count)
    end
  end

  context "Update" do
    it "should be successful" do
      visit(budgets_url)
      expect(current_url).to eq(budgets_url)
      expect(find(:css, "h1").text).to eq("Budget List for #{Date.today.year}")
      expect(page).to have_content(@budget.month)
      within('.table') do
        page.find('.show_budgets_link').click
      end
      expect(current_url).to eq("#{show_all_budgets_url}?month=#{@budget.month}&year=#{@budget.year}")
      expect(find(:css, "h1").text).to eq("All Budgets for #{Date::MONTHNAMES[@budget.month]}, #{@budget.year}")
      expect(Budget.last.amount.to_i).to eq(10000)
      within('.table') do
        page.find('.edit_link').click
      end
      expect(page).to have_content("Edit Budget Information")
      within('form') do
        fill_in 'budget_add', with: '5000'
      end
      click_on 'Submit'
      expect(page).to have_content("Budget has been updated successfully!!")
      expect(current_url).to eq("#{show_all_budgets_url}?month=#{@budget.month}&year=#{@budget.year}")
      expect(find(:css, "h1").text).to eq("All Budgets for #{Date::MONTHNAMES[@budget.month]}, #{@budget.year}")
      expect(Budget.last.amount.to_i).to eq(15000)
    end
  end
end