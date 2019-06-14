# frozen_string_literal: true

class AccrualStrategy
  def self.accrual_date?(_options)
    false
  end

  def self.calculate(start_date, end_date, amount, on)
    number_of_accrual_dates = (start_date...end_date).select do |date|
      accrual_date?(date, on)
    end.size

    amount * number_of_accrual_dates
  end
end
