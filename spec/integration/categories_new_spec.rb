require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  describe 'new' do
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
    it 'displays the form' do
      visit new_category_path
      expect(page).to have_content('Image link')
      expect(page).to have_content('Name')
      expect(page).to have_content('Add a Category')
    end
    after :all do
      @payment.destroy
      @category.destroy
      @user.destroy
    end
  end
end
