require 'rails_helper'

RSpec.describe Leafe, type: :model do
  before(:each) do
    @user = FactoryBot.build(:user)
    @allocated_leafe = FactoryBot.build(:allocated_leafe, user: @user)
    @leafe = FactoryBot.build(:leafe, user: @user)
  end

  describe "scope testing" do
    context ".with_leafe_type" do
      it "should return collection of leave with given type" do
        @leafe = FactoryBot.create(:leafe, leave_type: Leafe::TL, user: @user)
        expect(Leafe.with_leafe_type(Leafe::PL)).not_to include(@leafe)
      end
    end
  end

  describe "method testing" do
    context "#update_allocated_leave" do
      it "should update the user's allocated leave" do
        @leafe.status = 1
        @leafe.update_allocated_leave
        expect(@leafe.user.allocated_leafe.used_leave).to eq(3)
      end
    end

    context "#check_validity_of_leave" do
      it "should return true for valid date range" do
        days = Leafe.count_days(@leafe.start_date, @leafe.end_date)
        expect(@leafe.check_validity_of_leave(days)).to eq(true)
      end

      it "should return false for invalid date range" do
        @leafe.end_date = Date.today + 30.days
        days = Leafe.count_days(@leafe.start_date, @leafe.end_date)
        expect(@leafe.check_validity_of_leave(days)).to eq(false)
      end
    end

    context "#count_days" do
      it "should return 0 if start date is not present" do
        @leafe.start_date = nil
        days = Leafe.count_days(@leafe.start_date, @leafe.end_date)
        expect(days).to eq(0)
      end

      it "should return 0 if end date is not present" do
        @leafe.end_date = nil
        days = Leafe.count_days(@leafe.start_date, @leafe.end_date)
        expect(days).to eq(0)
      end

      it "should return number of days for valid date range" do
        days = Leafe.count_days(@leafe.start_date, @leafe.end_date)
        expect(days).to eq(3)
      end
    end

    context "#admin_approval" do
      it "should not approve leave if the user is not admin" do
        @leafe.user.role = 'Employee'
        @leafe.send(:admin_approval)
        expect(@leafe.status).not_to eq('approved')
      end

      it "should approve leave if the user is admin" do
        @leafe.send(:admin_approval)
        expect(@leafe.status).to eq('approved')
      end
    end
  end
end
