require 'rails_helper'

RSpec.describe Manage::UsersController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index, params: {id: @user.id}
      expect(assigns(:users)).not_to be_nil
      expect(response).to render_template(:index)
      expect(response).to be_successful
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new, params: {id: @user.id}
      expect(assigns(:user)).to be_new_record
      expect(response).to render_template(:new)
      expect(response).to be_successful
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      params = FactoryBot.attributes_for :user
      @user = FactoryBot.build(:user, email: params[:email], name: params[:name])
      post :create, params: {id: @user.id, user: params}
      last_created_user = User.last
      expect(last_created_user.email).to eq(@user.email)
      expect(last_created_user.name).to eq(@user.name)
      expect(last_created_user.phone).to eq(@user.phone)
      expect(last_created_user.target_amount).to eq(@user.target_amount)
      expect(last_created_user.bonus_percentage).to eq(@user.bonus_percentage)
      expect(last_created_user.role).to eq(@user.role)
      expect(response).to redirect_to(manage_users_url)
      expect(flash[:notice]).to eq("User has been created successfully")
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get :edit, params: {id: @user.id}
      expect(assigns(:user)).not_to be_new_record
      expect(response).to render_template(:edit)
      expect(response).to be_successful
    end
  end

  describe "PUT 'update'" do
    it "should be successful" do
      put :update, params: {id: @user.id, user: {name: "test name"}}
      @user.reload
      expect(response).to redirect_to(manage_user_url)
      expect(@user.name).to eq("test name")
      expect(flash[:notice]).to eq("User data has been updated successfully")
    end
  end

  describe "GET 'show_all_pending'" do
    it "should be successful" do
      get :show_all_pending, params: {id: @user.id, year: Date.today.year}
      expect(response).to render_template(:show_all_pending)
      expect(response).to be_successful
    end
  end

  describe "GET 'show_all_expenses'" do
    it "should be successful" do
      get :show_all_expenses, params: {id: @user.id}
      expect(response).to render_template(:show_all_expenses)
      expect(response).to be_successful
    end
  end

  describe "GET 'show_all_incomes'" do
    it "should be successful" do
      get :show_all_incomes, params: {id: @user.id}
      expect(response).to render_template(:show_all_incomes)
      expect(response).to be_successful
    end
  end
end
