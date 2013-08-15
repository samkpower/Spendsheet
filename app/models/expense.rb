class Expense < ActiveRecord::Base
	belongs_to :user

	validate :category, presence: true
	validate :amount, presence: true

	def self.year(year)
		where(created_at: year.beginning_of_year..year.end_of_year)
	end
end
