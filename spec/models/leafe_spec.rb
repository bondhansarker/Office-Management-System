require 'rails_helper'

RSpec.describe Leafe, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @allocated_leafe = FactoryBot.create(:allocated_leafe, user: @user)
  end

  describe "Leafe" do
    it "should not be created without start date" do
      @leafe = FactoryBot.build(:leafe, user: @user)
      @leafe.start_date = nil
      @leafe.save
      expect(@leafe.valid?).to eq(false)
    end

    it "should not be created without end date" do
      @leafe = FactoryBot.build(:leafe, user: @user)
      @leafe.end_date = nil
      @leafe.save
      expect(@leafe.valid?).to eq(false)
    end

    it "should not be created without reason" do
      @leafe = FactoryBot.build(:leafe, user: @user)
      @leafe.reason = nil
      @leafe.save
      expect(@leafe.valid?).to eq(false)
    end

    it "should be created with valid attribute" do
      count = 0
      @leafe = FactoryBot.build(:leafe, user: @user)
      @leafe.save
      expect(@leafe.valid?).to eq(true)
      expect(count+1).to eq(Leafe.count)
    end
  end
end
