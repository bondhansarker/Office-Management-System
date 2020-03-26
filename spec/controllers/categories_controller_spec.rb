require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  before(:each) do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      expect(assigns(:categories)).not_to be_nil
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      expect(assigns(:category)).to be_new_record
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      params = FactoryBot.attributes_for :category
      params.update({name: "New Category"})
      post :create, params: {category: params}
      last_created_category = Category.last
      expect(last_created_category.name).to eq("New Category")
      expect(response).to redirect_to(categories_url)
      expect(flash[:notice]).to eq("Category for Budget has been created successfully!!")
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get :edit, params: {id: @category.id}
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "PUT 'update'" do
    it "should be successful" do
      put :update, params: {id: @category.id, category: {name: "updated"}}
      @category.reload
      expect(response).to redirect_to(categories_path)
      expect(@category.name).to eq("updated")
      expect(flash[:notice]).to eq("Category for Budget has been updated successfully!!")
    end
  end
end
