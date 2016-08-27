class MonthTotal < ActiveRecord::Base
  belongs_to :year_totals
end
