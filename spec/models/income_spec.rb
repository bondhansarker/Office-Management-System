require 'rails_helper'

RSpec.describe Income, type: :model do
  before(:each) do
    @user = FactoryBot.build(:user)
  end

  describe "Create" do
    it "should be created with valid attributes" do
      count = 0
      @user.save
      @income = FactoryBot.create(:income, user: @user)
      @income.save
      expect(@income.valid?).to eq(true)
      expect(count+1).to eq(Income.count)
    end
  end

  describe "scope testing" do
    context ".find_in_income_date_by" do
      it "should return a collection of incomes when search is based on month" do
        @income = FactoryBot.build(:income, user: @user)
        @income.income_date = Date.today
        temp = (Date.today - 1.months).month
        expect(Income.find_in_income_date_by('month', temp)).not_to include(@income)
      end

      it "should return a collection of incomes when search is based on year" do
        @income = FactoryBot.build(:income, user: @user)
        @income.income_date = Date.today
        temp = (Date.today - 1.years).year
        expect(Income.find_in_income_date_by('year', temp)).not_to include(@income)
      end
    end
  end

  describe "method testing" do
    context "#find_incomes_by_months" do
      it "should return the sum of amount of user's incomes" do
        @income_1 = FactoryBot.create(:income, status: 1, income_date: "1950-01-01", user: @user)
        @income_2 = FactoryBot.create(:income, status: 1, income_date: "1950-01-05", user: @user)
        temp = @income_1.amount + @income_2.amount
        expect(Income.find_incomes_by_months(@user, 1, 1950)).to eq(temp)
      end
    end

    context "#find_total" do
      it "should return the sum of amount of user's incomes of a year" do
        @income_1 = FactoryBot.create(:income, status: 1, income_date: "1950-01-01", user: @user)
        @income_2 = FactoryBot.create(:income, status: 1, income_date: "1950-01-05", user: @user)
        temp = @income_1.amount + @income_2.amount
        expect(Income.find_total(@user, 1950)).to eq(temp)
      end
    end

    context "#bonus_amount" do
      it "should return bonus amount if income is greater than target amount" do
        @user.target_amount = 1000
        @user.bonus_percentage = 1
        @income = FactoryBot.create(:income, amount: 2000, income_date: "1950-01-05", user: @user)
        expect(Income.bonus_amount(@user, 1, 1950)).to eq(10)
      end

      it "should return 0 if income is less than target amount" do
        @user.target_amount = 100000
        @income = FactoryBot.create(:income, amount: 500, income_date: "1950-01-05", user: @user)
        expect(Income.bonus_amount(@user, 1, 1950)).to eq(0)
      end
    end

    context "#admin_approval" do
      it "should not approve income if the user is not admin" do
        @user.role = 'Employee'
        @income = FactoryBot.build(:income, user: @user)
        @income.send(:admin_approval)
        expect(@income.status).not_to eq('approved')
      end

      it "should approve income if the user is admin" do
        @income = FactoryBot.build(:income, user: @user)
        @income.send(:admin_approval)
        expect(@income.status).to eq('approved')
      end
    end
  end
end
