require 'rails_helper'

RSpec.describe Leafe, type: :model do
  before(:each) do
    @user = FactoryBot.build(:user)
    @allocated_leafe = FactoryBot.build(:allocated_leafe, user: @user)
    @income = FactoryBot.build(:income, user: @user)
  end

  describe "Create" do
    it "should be created with valid attributes" do
      count = 0
      @user.save
      @allocated_leafe.save
      @income.save
      expect(@income.valid?).to eq(true)
      expect(count+1).to eq(Leafe.count)
    end
  end

  describe "scope testing" do
    context ".with_leafe_type" do
      it "should return collection of leave with given type" do
        @income = FactoryBot.create(:income, leave_type: Leafe::TL, user: @user)
        expect(Leafe.with_leafe_type(Leafe::PL)).not_to include(@income)
      end
    end
  end

  describe "method testing" do
    context "#update_allocated_leave" do
      it "should update the user's allocated leave" do
        @income.status = 1
        @income.update_allocated_leave
        expect(@income.user.allocated_leafe.used_leave).to eq(3)
      end
    end

    context "#check_validity_of_leave" do
      it "should return true for valid date range" do
        days = Leafe.count_days(@income.start_date, @income.end_date)
        expect(@income.check_validity_of_leave(days)).to eq(true)
      end

      it "should return false for invalid date range" do
        @income.end_date = Date.today + 30.days
        days = Leafe.count_days(@income.start_date, @income.end_date)
        expect(@income.check_validity_of_leave(days)).to eq(false)
      end
    end

    context "#count_days" do
      it "should return 0 if start date is not present" do
        @income.start_date = nil
        days = Leafe.count_days(@income.start_date, @income.end_date)
        expect(days).to eq(0)
      end

      it "should return 0 if end date is not present" do
        @income.end_date = nil
        days = Leafe.count_days(@income.start_date, @income.end_date)
        expect(days).to eq(0)
      end

      it "should return number of days for valid date range" do
        days = Leafe.count_days(@income.start_date, @income.end_date)
        expect(days).to eq(3)
      end
    end

    context "#admin_approval" do
      it "should not approve leave if the user is not admin" do
        @income.user.role = 'Employee'
        @income.send(:admin_approval)
        expect(@income.status).not_to eq('approved')
      end

      it "should approve leave if the user is admin" do
        @income.send(:admin_approval)
        expect(@income.status).to eq('approved')
      end
    end
  end
end
