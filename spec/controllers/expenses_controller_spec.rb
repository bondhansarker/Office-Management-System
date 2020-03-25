require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do

  before(:each) do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    @budget = FactoryBot.create(:budget, user: @user, category: @category)
    @expense = FactoryBot.create(:expense, user: @user, category: @category)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      expect(assigns(:expenses)).not_to be_nil
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end

end
