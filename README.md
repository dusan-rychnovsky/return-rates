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

Should return:
```
Interest rate: 10.1% p.a.
```
