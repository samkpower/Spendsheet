class Expense < ActiveRecord::Base
	belongs_to :user

	validate :category, presence: true
	validate :amount, presence: true
end
