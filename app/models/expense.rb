class Expense < ActiveRecord::Base
	belongs_to :user

	validate :category, presence: true
	validate :amount, presence: true

	def self.year(year)
		date = DateTime.new(year)
		where(created_at: date.beginning_of_year..date.end_of_year)
	end

	def self.month(month)
		date = DateTime.parse(month)
		where(created_at: date.beginning_of_month..date.end_of_month)
	end

	def self.day(day)
		date = DateTime.parse(day)
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
end
