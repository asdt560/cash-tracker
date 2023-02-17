require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  describe 'GET payments#index' do
    before(:each) do
      @user = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                       encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user.skip_confirmation!
      @user.confirm
      @user.save
      @category = Category.create(name: 'expenses', icon: '#', user: @user)
      @payment = Payment.create(name: 'payment1', amount: 1000, author: @user, category_ids: @category.id)
      sign_in @user
      get "/categories/#{@category.id}/payments"
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'includes text' do
      expect(response.body).to include(@payment.name)
    end
  end

  describe 'GET payments#new' do
    before(:each) do
      @user = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                       encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user.skip_confirmation!
      @user.confirm
      @user.save
      @category = Category.create(name: 'expenses', icon: '#', user: @user)
      sign_in @user
      get "/categories/#{@category.id}/payments/new"
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('new')
    end

    it 'includes text' do
      expect(response.body).to include('Add a Transaction')
    end
  end
  describe 'POST payments#create' do
    before(:each) do
      @user = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                       encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user.skip_confirmation!
      @user.confirm
      @user.save
      sign_in @user
      @category = Category.create(name: 'expenses', icon: '#', user: @user)
      get "/categories/#{@category.id}/payments/new"
    end

    it 'creates a new recipe item' do
      post "/categories/#{@category.id}/payments",
           params: { payment: { name: 'expenses', amount: 1000, author: @user, category_ids: @category.id } }
      get "/categories/#{@category.id}/payments"
      expect(response.body).to include('expenses')
    end
  end
end
