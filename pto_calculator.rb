# frozen_string_literal: true

class PtoCalculator
  def self.calculate(options)
    start_date = options[:start_date]
    end_date = options[:end_date]
    accrual_rule = options[:accrual_rule]
    amount = accrual_rule[:days] || accrual_rule[:hours] || 0
    accrued = AccrualStrategyFactory
              .build(accrual_rule[:period])
              .calculate(start_date, end_date, amount, accrual_rule[:on])

    (options[:balance] + accrued).round(2)
  end
end
