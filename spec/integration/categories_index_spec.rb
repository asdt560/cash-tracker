require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  describe 'index' do
    before :all do
      @user = User.new(name: 'nameofuser', email: 'asdt56062@gmail.com', password: '6letters',
                       encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user.skip_confirmation!
      @user.confirm
      @user.save
      sign_in @user
      @category = Category.create(name: 'expenses', icon: '#', user: @user)
      @payment = Payment.create(name: 'payment1', amount: 1000, author: @user, category_ids: @category.id)
    end
    it 'displays the categories and information' do
      visit categories_path
      expect(page).to have_content(@category.name)
      expect(page).to have_content('$10.00')
      expect(page).to have_content('ADD A NEW CATEGORY')
    end
    after :all do
      @payment.destroy
      @category.destroy
      @user.destroy
    end
  end
end
