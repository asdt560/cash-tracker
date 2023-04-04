class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :payments
  validates :name, presence: true
  has_one_attached :image
  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  def sum_of_payments
    payments = self.payments
    total = 0
    payments.each do |payment|
      total += payment.amount
    end
    total
  end
end
