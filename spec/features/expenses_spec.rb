require 'rails_helper'

RSpec.feature "Expenses", type: :feature do

  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end

  context "Index" do
    scenario "should be successful" do

    end

    scenario "should fail" do

    end

  end
end
