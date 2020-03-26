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


  # describe "POST 'create'" do
  #   it "should be successful" do
  #     post :create
  #     last_created_attendance = Attendance.last
  #     expect(last_created_attendance.date).to eq(Date.today.to_date)
  #     expect(last_created_attendance.status).to eq(true)
  #     expect(response).to redirect_to(:back)
  #     expect(flash[:notice]).to eq("You have Checked In Successfully!!")
  #   end
  # end
  #
  # describe "PUT 'update'" do
  #   it "should be successful" do
  #     put :update, params: {id: @attendance.id}
  #     @attendance.reload
  #     expect(@attendance.status).to eq(false)
  #     expect(flash[:notice]).to eq("You have checked Out Successfully!!")
  #   end
  # end

end
