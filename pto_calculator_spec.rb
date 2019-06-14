# frozen_string_literal: true

require 'date'
require 'business_time'
require File.join(File.dirname(__FILE__), 'pto_calculator')
require File.join(File.dirname(__FILE__), 'accrual_strategies', 'accrual_strategy')
require File.join(File.dirname(__FILE__), 'accrual_strategies', 'annual_accrual_strategy')
require File.join(File.dirname(__FILE__), 'accrual_strategies', 'monthly_accrual_strategy')
require File.join(File.dirname(__FILE__), 'accrual_strategies', 'weekly_accrual_strategy')
require File.join(File.dirname(__FILE__), 'accrual_strategies', 'accrual_strategy_factory')

describe PtoCalculator do
  it 'returns balance after a month without any accrual' do
    options = {
      balance: 0,
      start_date: Date.new(2019, 1, 1),
      end_date: Date.new(2019, 1, 31),
      accrual_rule: {
      }
    }

    expect(PtoCalculator.calculate(options)).to be(0)
  end

  it 'returns balance after a month with 1d per month accrual and accrue on day 1' do
    options = {
      balance: 0,
      start_date: Date.new(2019, 1, 1),
      end_date: Date.new(2019, 1, 31),
      accrual_rule: {
        days: 1,
        period: :month,
        on: 1
      }
    }

    expect(PtoCalculator.calculate(options)).to be_within(0.1).of(1)
  end

  it 'returns balance after a month with 1d per month accrual and accrue on the 10th day and start on the day before' do
    options = {
      balance: 0,
      start_date: Date.new(2019, 1, 9),
      end_date: Date.new(2019, 1, 31),
      accrual_rule: {
        days: 1,
        period: :month,
        on: 10
      }
    }

    expect(PtoCalculator.calculate(options)).to be_within(0.1).of(1)
  end

  it 'returns balance after a month with 1d per month accrual and accrue on the 10th day and start on the day after' do
    options = {
      balance: 0,
      start_date: Date.new(2019, 1, 11),
      end_date: Date.new(2019, 1, 31),
      accrual_rule: {
        days: 1,
        period: :month,
        on: 10
      }
    }

    expect(PtoCalculator.calculate(options)).to be_within(0.1).of(0)
  end

  it 'returns balance after two months with 1d per month accrual' do
    options = {
      balance: 0,
      start_date: Date.new(2019, 1, 1),
      end_date: Date.new(2019, 2, 28),
      accrual_rule: {
        days: 1,
        period: :month,
        on: 1
      }
    }

    expect(PtoCalculator.calculate(options)).to be_within(0.1).of(2)
  end

  it 'returns balance after one month with 1d per month accrual and a positive starting balance' do
    options = {
      balance: 10,
      start_date: Date.new(2019, 1, 1),
      end_date: Date.new(2019, 1, 31),
      accrual_rule: {
        days: 1,
        period: :month,
        on: 1
      }
    }

    expect(PtoCalculator.calculate(options)).to be_within(0.1).of(11)
  end

  it 'returns balance after one month with 1d per month accrual on the last day of the month' do
    options = {
      balance: 10,
      start_date: Date.new(2019, 1, 1),
      end_date: Date.new(2019, 1, 30),
      accrual_rule: {
        days: 1,
        period: :month,
        on: 31
      }
    }

    expect(PtoCalculator.calculate(options)).to be_within(0.1).of(10)
  end

  it 'returns balance after one month with 1d per week accrual accruing on Monday' do
    options = {
      balance: 0,
      start_date: Date.new(2019, 1, 1),
      end_date: Date.new(2019, 1, 31),
      accrual_rule: {
        days: 1,
        period: :week,
        on: :monday
      }
    }

    expect(PtoCalculator.calculate(options)).to be_within(0.1).of(4)
  end

  it 'returns balance after one month with 1d per week accrual accruing on Tuesday' do
    options = {
      balance: 0,
      start_date: Date.new(2019, 1, 1),
      end_date: Date.new(2019, 1, 31),
      accrual_rule: {
        days: 1,
        period: :week,
        on: :tuesday
      }
    }

    expect(PtoCalculator.calculate(options)).to be_within(0.1).of(5)
  end

  it 'returns balance after one year with 1d per year accrual' do
    options = {
      balance: 0,
      start_date: Date.new(2019, 1, 1),
      end_date: Date.new(2019, 12, 31),
      accrual_rule: {
        days: 10,
        period: :year,
        on: 1
      }
    }

    expect(PtoCalculator.calculate(options)).to be_within(0.1).of(10)
  end

  it 'returns balance after one year with 1d per year accrual and start 1 day after accrual date' do
    options = {
      balance: 0,
      start_date: Date.new(2019, 1, 16),
      end_date: Date.new(2019, 12, 31),
      accrual_rule: {
        days: 10,
        period: :year,
        on: 15
      }
    }

    expect(PtoCalculator.calculate(options)).to be_within(0.1).of(0)
  end

  it 'returns balance after one year with 1d per month accrual and start 1 day before accrual date' do
    options = {
      balance: 0,
      start_date: Date.new(2019, 1, 14),
      end_date: Date.new(2019, 12, 31),
      accrual_rule: {
        days: 1,
        period: :month,
        on: 15
      }
    }

    expect(PtoCalculator.calculate(options)).to be_within(0.1).of(12)
  end

  it 'returns balance after one year with 8h per month accrual and start 1 day before accrual date' do
    options = {
      balance: 0,
      start_date: Date.new(2019, 1, 14),
      end_date: Date.new(2019, 12, 31),
      accrual_rule: {
        hours: 8,
        period: :month,
        on: 15
      }
    }

    expect(PtoCalculator.calculate(options)).to be_within(0.1).of(8 * 12)
  end

  it 'maximum accrual'
  it 'reset balance to X on date'
  it 'adjust balance'
  it 'increase balance by amount (reward PTO time)'
  it 'decrease balance by amount (log PTO time)'
end
