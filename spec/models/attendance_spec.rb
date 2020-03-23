require 'rails_helper'

RSpec.describe Attendance, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @attendance = FactoryBot.build(:attendance, user: @user)
  end

  describe "Attendance" do
    it "should be created with valid attribute" do
      count = 0
      @attendance.save
      expect(@attendance.valid?).to eq(true)
      expect(count+1).to eq(Attendance.count)
    end
  end

  describe "Attendance" do
    it "should be created with unique of user and date attribute" do
      count = 0
      @attendance.save
      duplicate = FactoryBot.build(:attendance, user: @user)
      duplicate.save
      expect(duplicate.valid?).to eq(false)
      expect(duplicate.errors.full_messages.include?("Date has already been taken")).to eq(true)
      expect(count+1).to eq(Attendance.count)
    end
  end
end
