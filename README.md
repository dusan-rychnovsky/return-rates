# Return rates calculator

Given a list of historic contributions to a financial vehicle and a current value, calculates the corresponding yearly interest rate.

## Usage

```
ruby rates.rb [calendar] [current-value]

where:
- calendar - a list of monthly contributions in the following format:
  [period]+[period]+...+[period]
  where each period is expressed as:
  [value]x[num-months]
```

For example:
```
ruby rates.rb 3000x4+6000x51 398991.05
```

means that the contributions were 3000 the first 4 months and then 6000 the next 51 months\
and should return:
```
Interest rate: 10.1% p.a.
```

## How it works

The correct return rate is approximated using binary search. The result is accurate with 0.1% precision.
