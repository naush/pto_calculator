# frozen_string_literal: true

class MonthlyAccrualStrategy < AccrualStrategy
  def self.accrual_date?(date, on)
    end_of_month = on == 31

    if end_of_month
      date == date.at_end_of_month
    else
      date.day == on
    end
  end
end
