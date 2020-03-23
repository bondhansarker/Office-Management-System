require 'rails_helper'

RSpec.describe Expense, type: :model do

  before(:each) do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    @budget = FactoryBot.build(:budget, user: @user, category: @category)
  end

  describe "Expense" do
    it "should be created with valid attribute" do
      count = 0
      @budget.save
      expense = FactoryBot.build(:expense, user: @user, category: @category)
      expense.save
      expect(expense.valid?).to eq(true)
      expect(count+1).to eq(Expense.count)
    end
  end


  describe "Expense" do
    it "should be created with valid budget year" do
      count = 0
      @budget.year = 2021
      @budget.save
      expense = FactoryBot.build(:expense, user: @user, category: @category)
      expense.save
      expect(expense.valid?).to eq(false)
      expect(expense.errors.full_messages.include?("Budget for January, 2020 is not submitted yet!!")).to eq(true)
      expect(count).to eq(Expense.count)
    end
  end

  describe "Expense" do
    it "should be created with valid budget month" do
      count = 0
      @budget.month = 8
      @budget.save
      expense = FactoryBot.build(:expense, user: @user, category: @category)
      expense.save
      expect(expense.valid?).to eq(false)
      expect(expense.errors.full_messages.include?("Budget for January, 2020 is not submitted yet!!")).to eq(true)
      expect(count).to eq(Expense.count)
    end
  end

  describe "Expense" do
    it "should be created with valid attribute with integer cost" do
      count = 0
      @budget.save
      expense = FactoryBot.build(:expense, user: @user, category: @category)
      expense.cost = "ss"
      expense.save
      expect(expense.valid?).to eq(false)
      expect(expense.errors.full_messages.include?("Cost is not a number")).to eq(true)
      expect(count).to eq(Expense.count)
    end
  end


end
