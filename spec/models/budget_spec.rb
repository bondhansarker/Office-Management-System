require 'rails_helper'

RSpec.describe Budget, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    @budget = FactoryBot.build(:budget, user: @user, category: @category)
  end

  describe "Budget" do
    it "should be created with valid attribute" do
      count = 0
      @budget.save
      expect(@budget.valid?).to be(true)
      expect(count+1).to eq(Budget.count)
    end
  end

  describe "Budget" do
    it "should add budget with existing budget" do
      amount = @budget.amount
      @budget.save
      @budget.update({add: 2000})
      expect(@budget.amount).to eq(amount+2000)
    end
  end

  describe "Budget" do
    it "should search budgets with year and month" do
      @budget.save
      expect(Budget.search_with(2020,1).first).to eq(@budget)
      expect(Budget.search_with(2020,1).sum(:amount)).to eq(@budget.amount)
      expect(Budget.search_with(2020,1).sum(:expense)).to eq(@budget.expense)
    end
  end

end
