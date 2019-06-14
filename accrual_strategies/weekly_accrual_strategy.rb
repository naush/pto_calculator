class WeeklyAccrualStrategy < AccrualStrategy
  def self.accrual_date?(date, on)
    date.send("#{on}?")
  end
end
