class Expense < ActiveRecord::Base
	belongs_to :user
	belongs_to :category

	validate :category, presence: true
	validate :amount, presence: true

	def category_name
		category.try(:name)
	end

	def category_name=(name)
		self.category = Category.find_or_create_by_name(name: name, user_id: user_id) if name.present?
	end

	def self.group_by_category
		group("category").sum("amount")
	end

	def self.year(year)
		date = DateTime.new(year)
		where(created_at: date.beginning_of_year..date.end_of_year)
	end

	def self.month(date)
		where(created_at: date.beginning_of_month..date.end_of_month)
	end

	def self.day(year, month, day)
		date = DateTime.parse("#{year.to_s}/#{month.to_s}/#{day.to_s}")
		where(created_at: date.beginning_of_day..date.end_of_day)
	end

	def self.today
		today = Time.zone.now
		where(created_at: today.beginning_of_day..today.end_of_day)
	end

	def self.this_week
		today = Time.zone.now
		where(created_at: today.beginning_of_week(start_day = :sunday)..today.end_of_week)
	end

	def self.this_month
		today = Time.zone.now
		where(created_at: today.beginning_of_month..today.end_of_month)
	end

	def self.this_year
		today = Time.zone.now
		where(created_at: today.beginning_of_year..today.end_of_year)
	end

	def self.sum_expenses(expenses)
		expenses.sum(&:amount)
	end
end
