require 'rails_helper'

RSpec.describe AllocatedLeafe, type: :model do

  before(:each) do
    @user = FactoryBot.create(:user)
    @allocated_leafe = FactoryBot.build(:allocated_leafe, user: @user)
  end

  describe "Allocated Leafe" do
    it "should be created with valid attribute" do
      count = 0
      @allocated_leafe.save
      expect(@allocated_leafe.valid?).to eq(true)
      expect(count+1).to eq(AllocatedLeafe.count)
    end
  end

  describe "Allocated Leafe" do
    it "should be created with one user for one year" do
      count = 0
      @allocated_leafe.save
      expect(@allocated_leafe.valid?).to eq(true)
      expect(count+1).to eq(AllocatedLeafe.count)

      duplicate = FactoryBot.build(:allocated_leafe, user: @user)
      duplicate.save
      expect(duplicate.valid?).to eq(false)
      expect(count+1).to eq(AllocatedLeafe.count)

      duplicate.year = 2021
      duplicate.save
      expect(duplicate.valid?).to eq(true)
      expect(count+2).to eq(AllocatedLeafe.count)
    end
  end

end
