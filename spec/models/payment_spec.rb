require 'rails_helper'

RSpec.describe Payment, type: :model do
  before :each do
    @user = User.new(name: 'nameofuser', email: 'asdt56062@gmail.com', password: '6letters',
                      encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
    @user.skip_confirmation!
    @user.confirm
    @user.save
    @category = Category.create(name:"expenses", icon:"#", user: @user)
    @payment1 = Payment.create(name:'payment1', amount: 1000, author: @user, category_ids: @category.id)
  end

  it 'name should be present' do
    @payment1.name = nil
    expect(@payment1).to_not be_valid
  end

  it 'amount should be present' do
    @payment1.amount = nil
    expect(@payment1).to_not be_valid
  end

  it 'category_ids should be present' do
    @payment1.category_ids = nil
    expect(@payment1).to_not be_valid
  end
end