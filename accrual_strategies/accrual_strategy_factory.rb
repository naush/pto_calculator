class AccrualStrategyFactory
  DEFAULT_ACCRUAL_STRATEGY = MonthlyAccrualStrategy

  PERIOD_ACCRUAL_STRATEGY_MAP = {
    month: MonthlyAccrualStrategy,
    week: WeeklyAccrualStrategy,
    year: AnnualAccrualStrategy
  }

  def self.build(period)
    PERIOD_ACCRUAL_STRATEGY_MAP.fetch(period, DEFAULT_ACCRUAL_STRATEGY)
  end
end
