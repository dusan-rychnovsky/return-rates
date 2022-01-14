PRECISION = 3 # 3 decimal digits equals 0.1% precision

def parse_args args
  if args.length != 2
    puts "Expected 2 arguments 'calendar current-value', got #{args.length}"
    exit
  else
    calendar = Calendar.parse args[0]
    current_value = args[1].to_i
    return calendar, current_value
  end
end

class Calendar
  include Enumerable

  def self.parse expr
    periods = expr.split "+"
    months = periods.map { |period| parse_period(period) }.flatten
    return Calendar.new months
  end

  def self.parse_period expr
    amount, num_months = expr.split "x"
    return Array.new(num_months.to_i, amount.to_i)
  end

  def initialize months
    @months = months
  end
  
  def each(&block)
    @months.each(&block)
  end

  def to_s
    @months.join '+'
  end
end

class Calculator

  def current_value calendar, ir
    monthly_interest_rate = ir / 12.0
    calendar.reduce 0 do |acc, payment|
      acc * (1 + monthly_interest_rate) + payment
    end
  end

  def interest_rate calendar, cv
    ir = 1.0
    ir_upper = ir_lower = nil
    while true do
      value = current_value calendar, ir

      if value > cv then
        ir_upper = ir
      end
      if value < cv then
        ir_lower = ir
      end
      
      if ir_lower && ir_upper then
        if ir_lower.round(PRECISION) == ir_upper.round(PRECISION) then
          return ir
        end
        if value < cv then
          ir = (ir + ir_upper) / 2.0
        elsif value > cv then
          ir = (ir_lower + ir) / 2.0
        else
          return ir
        end
      elsif ir_lower then
        ir = 2.0 * ir_lower
      elsif ir_upper then
        ir = ir_upper / 2.0
      else
        throw "At least one of ir_lower, ir_upper should always be known."
      end
    end
  end
end

calculator = Calculator.new
calendar, current_value = parse_args ARGV
yearly_interest_rate = calculator.interest_rate calendar, current_value
puts "Interest rate: #{(yearly_interest_rate * 100).round(1)}% p.a."
