require 'rails_helper'

RSpec.feature "Expense", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
    @user.role = "Employee"
    @user.save
    @category = FactoryBot.create(:category)
    @budget = FactoryBot.create(:budget, user: @user, category: @category)
    @expense = FactoryBot.create(:expense, user: @user, category: @category)
    login_as(@user, :scope => :user)
  end

  describe "Create" do
    it "should be successful" do
      visit(root_url)
      click_on 'Expense'
      click_on 'Add new expense'
      expect(current_url).to eq(new_expense_url)
      expect(find(:css, "h1").text).to eq("Insert Expense Information")
      within('form') do
        fill_in 'expense_product_name', with: 'Test Expense form'
        fill_in 'expense_cost', with: '1000'
        fill_in 'datepicker', with: '2020-01-01'
      end
      click_on 'Submit'
      expect(page).to have_content("Expense has been submitted for approval")
      expect(current_url).to eq(expenses_url)
      expect(find(:css, "h1").text).to eq("Expense List")
      expect(2).to eq(Expense.count)
      expect(page).to have_content("Pending (#{Expense.pending.count})")
      expect(page).to have_content("Test Expense form")
    end
  end

  describe "Show" do
    context "Pending" do
      it "should be successful" do
        visit(expenses_url)
        expect(current_url).to eq(expenses_url)
        expect(find(:css, "h1").text).to eq("Expense List")
        expect(page).to have_content("Pending (#{Expense.pending.count})")
        expect(page).to have_content(@expense.product_name)
        within('#pending') do
          page.find('.show_link').click
        end
        within('.card') do
          expect(page).to have_content(@expense.product_name)
          expect(page).to have_content("Pending")
          expect(current_url).to eq(expense_url(@expense))
        end
        page.find('.btn-dark').click
        expect(current_url).to eq(expenses_url)
      end
    end

    context "Approved" do
      it "should be successful" do
        @expense.approved!
        visit(expenses_url)
        expect(current_url).to eq(expenses_url)
        expect(find(:css, "h1").text).to eq("Expense List")
        expect(page).to have_content("Approved (#{Expense.approved.count})")
        expect(page).to have_content(@expense.product_name)
        within('#approved') do
          page.find('.show_link').click
        end
        within('.card') do
          expect(page).to have_content(@expense.product_name)
          expect(page).to have_content("Approve Time")
          expect(current_url).to eq(expense_url(@expense))
        end
        page.find('.btn-dark').click
        expect(current_url).to eq(expenses_url)
      end
    end
  end

  context "Destroy" do
    it "should be successful" do
      visit(expenses_url)
      expect(current_url).to eq(expenses_url)
      expect(find(:css, "h1").text).to eq("Expense List")
      expect(page).to have_content("Pending (#{Expense.pending.count})")
      expect(page).to have_content(@expense.product_name)
      expect(1).to eq(Expense.count)
      within('#pending') do
        page.find('.destroy_link').click
      end
      expect(current_url).to eq(expenses_url)
      expect(0).to eq(Expense.count)
      expect(page).to have_content("Pending (#{Expense.pending.count})")
    end
  end

  context "Update" do
    it "should be successful" do
      visit(expenses_url)
      expect(current_url).to eq(expenses_url)
      expect(find(:css, "h1").text).to eq("Expense List")
      within('#pending') do
        page.find('.edit_link').click
      end
      expect(page).to have_content("Edit Expense Information")
      within('form') do
        fill_in 'expense_product_name', with: 'Test Expense'
      end
      click_on 'Update'
      expect(page).to have_content("Expense has been updated successfully!!")
      expect(current_url).to eq(expenses_url)
      expect(find(:css, "h1").text).to eq("Expense List")
      expect(page).to have_content("Test Expense")
      expect(Expense.last.product_name).to eq("Test Expense")
    end
  end

  context "Reject" do
    it "should be successful" do
      @user = FactoryBot.create(:user)
      @user.role = "Admin"
      @user.save
      login_as(@user, :scope => :user)
      visit(expenses_url)

      expect(current_url).to eq(expenses_url)
      expect(find(:css, "h1").text).to eq("Expense List")
      expect(0).to eq(Expense.rejected.count)
      expect(1).to eq(Expense.pending.count)
      within('#pending') do
        page.find('.reject_link').click
      end
      expect(page).to have_content("Expense has been rejected successfully!!")
      expect(current_url).to eq(expenses_url)
      expect(1).to eq(Expense.rejected.count)
      expect(0).to eq(Expense.pending.count)
      expect(page).to have_content("Rejected (#{Expense.rejected.count})")
    end
  end

  describe "Approval" do
    context "Approve" do
      it "should be successful" do
        @user = FactoryBot.create(:user)
        @user.role = "Admin"
        @user.save
        login_as(@user, :scope => :user)
        visit(expenses_url)

        visit(expenses_url)
        expect(current_url).to eq(expenses_url)
        expect(find(:css, "h1").text).to eq("Expense List")
        expect(0).to eq(Expense.approved.count)
        expect(1).to eq(Expense.pending.count)

        within('#pending') do
          page.find('.approve_link').click
        end
        expect(page).to have_content("Expense has been approved successfully!!")
        expect(current_url).to eq(expenses_url)

        expect(0).to eq(Expense.pending.count)
        expect(1).to eq(Expense.approved.count)
        expect(page).to have_content("Approved (#{Expense.approved.count})")
        expect(page).to have_content("Pending (#{Expense.pending.count})")
      end
    end

    context "Undo" do
      it "should be successful" do
        @user = FactoryBot.create(:user)
        @user.role = "Admin"
        @user.save
        login_as(@user, :scope => :user)
        @expense.approved!

        visit(expenses_url)
        expect(current_url).to eq(expenses_url)
        expect(find(:css, "h1").text).to eq("Expense List")
        expect(1).to eq(Expense.approved.count)
        expect(0).to eq(Expense.pending.count)

        within('#approved') do
          page.find('.undo_link').click
        end
        expect(page).to have_content("The Expense has been queued for pending!!")
        expect(current_url).to eq(expenses_url)
        expect(1).to eq(Expense.pending.count)
        expect(0).to eq(Expense.approved.count)
        expect(page).to have_content("Approved (#{Expense.approved.count})")
        expect(page).to have_content("Pending (#{Expense.pending.count})")
      end
    end
  end
end