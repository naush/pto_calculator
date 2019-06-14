# frozen_string_literal: true

class WeeklyAccrualStrategy < AccrualStrategy
  def self.accrual_date?(date, on)
    date.send("#{on}?")
  end
end
