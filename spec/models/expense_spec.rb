require 'rails_helper'

RSpec.describe Expense, type: :model do

  before(:each) do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    @budget = FactoryBot.build(:budget, user: @user, category: @category)
    @expense = FactoryBot.build(:expense, user: @user, category: @category)
  end

  describe "Expense" do
    it "should be created with valid attribute" do
      count = 0
      @budget.save
      @expense.save
      expect(@expense.valid?).to eq(true)
      expect(count+1).to eq(Expense.count)
    end
  end

  describe "Expense" do
    it "should be approved automatically submitted by admin" do
      @expense = FactoryBot.build(:expense, user: @user, category: @category)
      @budget.save
      @expense.save
      expect(@expense.cost).to eq(@expense.budget.expense)
      expect(Expense.approved.count).to eq(1)
    end
  end

  describe "Expense" do
    it "should decrease budget amount by approving an expense" do
      @expense.user.role = "Employee"
      @budget.save
      @expense.save
      @expense.approved!
      @expense.update_budget
      expect(@expense.cost).to eq(@expense.budget.expense)
    end
  end

  describe "Expense" do
    it "should increase budget amount by making undo of an expense" do
      @expense.user.role = "Employee"
      @budget.save
      @expense.save
      @expense.approved!
      @expense.update_budget
      @expense.pending!
      @expense.update_budget
      expect(@expense.budget.expense).to eq(0)
    end
  end

  describe "Expense" do
    it "should be created with valid budget year" do
      count = 0
      @budget.year = 2021
      @budget.save
      @expense.save
      expect(@expense.valid?).to be(false)
      expect(@expense.errors.full_messages.include?("Budget for January, 2020 is not submitted yet!!")).to be(true)
      expect(count).to eq(Expense.count)
    end
  end

  describe "Expense" do
    it "should be created with valid budget month" do
      count = 0
      @budget.month = 8
      @budget.save
      @expense.save
      expect(@expense.valid?).to be(false)
      expect(@expense.errors.full_messages.include?("Budget for January, 2020 is not submitted yet!!")).to be(true)
      expect(count).to eq(Expense.count)
    end
  end
end
