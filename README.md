# Return rates calculator

Given a list of historic contributions to a financial vehicle and a current value, calculates the corresponding yearly interest rate.

```
ruby rates.rb [calendar] [current-value]

where:
- calendar - a list of monthly contributions in the following format:
  [value]x[num-months]
```

For example:
```
ruby rates.rb 3900x58 261876.27
```

Should return:
```
Interest rate: 6.0% p.a.
```
