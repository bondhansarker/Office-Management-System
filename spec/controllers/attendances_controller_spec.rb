require 'rails_helper'

RSpec.describe AttendancesController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    @attendance = FactoryBot.create(:attendance, user: @user)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      expect(assigns(:attendances)).not_to be_nil
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end
end
