require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET users#index' do
    before(:each) do
      get '/'
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'includes text' do
      expect(response.body).to include('Cash Tracker')
    end
  end
  describe 'GET users#show' do
    before(:each) do
      @user = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                       encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user.skip_confirmation!
      @user.confirm
      @user.save
      sign_in @user
      get '/users'
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template('show')
    end

    it 'includes text' do
      expect(response.body).to include(@user.name)
    end
end
