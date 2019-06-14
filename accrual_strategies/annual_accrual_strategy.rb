# frozen_string_literal: true

class AnnualAccrualStrategy < AccrualStrategy
  def self.accrual_date?(date, on)
    date.yday == on
  end
end
