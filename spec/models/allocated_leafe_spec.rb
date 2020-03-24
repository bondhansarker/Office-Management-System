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

end
