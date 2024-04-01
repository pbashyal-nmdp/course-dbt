# Analytics engineering with dbt

## License
GPL-3.0

## Week 2

### Part 1. Models 

#### What is our user repeat rate?

> Repeat Rate = Users who purchased 2 or more times / users who purchased

```
0.798387
```


### Explain the product mart models you added. Why did you organize the models in the way you did?

I added `fact_page_views` fact model and `int_active_product_promo` intermediate model that has the active product list and their corresponding promos.

I created models directory to match product, marketing organization.

### What assumptions are you making about each model? (i.e. why are you adding each test?)

I wanted to make sure all the ids are unique in product and users.

### Which products had their inventory change from week 1 to week 2? 

```
Pothos
Philodendron
Monstera
String of pearls
```

## Week 1

### How many users do we have?

130

### On average, how many orders do we receive per hour?

15.041667

### On average, how long does an order take from being placed to being delivered?

93.403279 hours

### How many users have only made one purchase? Two purchases? Three+ purchases?

1 Purchase: 25
2 Purchases: 28
3+ Purchases: 71

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

### On average, how many unique sessions do we have per hour?

3.751848
