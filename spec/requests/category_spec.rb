require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET categories#index' do
    before(:each) do
      @user = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user.skip_confirmation!
      @user.confirm
      @user.save
      @category = Category.create(name:"expenses", icon:"#", user: @user)
      sign_in @user
      get '/categories'
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'includes text' do
      expect(response.body).to include(@category.name)
    end
  end

  describe 'GET categories#new' do
    before(:each) do
      @user = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user.skip_confirmation!
      @user.confirm
      @user.save
      @category = Category.create(name:"expenses", icon:"#", user: @user)
      sign_in @user
      get '/categories/new'
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('new')
    end

    it 'includes text' do
      expect(response.body).to include("Add a Category")
    end
  end
  describe 'POST categories#create' do
    before(:each) do
      @user = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user.skip_confirmation!
      @user.confirm
      @user.save
      sign_in @user
      get '/categories/new'
    end

    it 'creates a new recipe item' do
      post '/categories', params: { category: { name: 'expenses', icon: '#', user: @user } }
      get '/categories'
      expect(response.body).to include('expenses')
    end
  end
end