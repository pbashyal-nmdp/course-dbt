# Analytics engineering with dbt

## License
GPL-3.0

## Week 4

### Part 1: dbt Snapshots

The following products had their inventory change from week 3 to week 4.

|PRODUCT_ID                          |NAME            |PRICE|
|------------------------------------|----------------|-----|
|fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80|String of pearls|80.5 |
|be49171b-9f72-4fc9-bf7a-9a52e259836b|Monstera        |50.75|
|55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3|Philodendron    |45   |
|4cda01b9-62e2-46c5-830f-b7f262a58fb1|Pothos          |30.5 |
|b66a7143-c18a-43bb-b5dc-06bb5d1d3160|ZZ Plant        |25   |
|689fb64e-a4a2-45c5-b9f2-480c2155624d|Bamboo          |15.25|

SQL Query:
```sql
select name, price
from DEV_DB.DBT_PBASHYALNMDPORG.INVENTORY_SNAPSHOT
where DBT_VALID_FROM >= date('2024-04-15')
order by price desc ;
```



#### Part 2: Modeling challenge

Added page_view, add_to_card and checkout models.

### Part 3:

I'd setup Dagster and CI to have dbt build/update daily.

## Week 3

### Part 1

#### What is our overall conversion rate?

> 16.267900

The model creates a view for this result.

```
greenery/models/staging/postgres/stg_overall_conversion_rate.sql
```

#### What is our conversion rate by product?

The following table lists the conversion rate by product.

| NAME | PRICE | CONVERSATION\_RATE |
| :--- | :--- | :--- |
| Aloe Vera | 15 | 74.41 |
| Arrow Head | 30.95 | 70.00 |
| Jade Plant | 15 | 68.75 |
| String of pearls | 80.5 | 68.42 |
| Rubber Plant | 20.5 | 66.66 |
| Philodendron | 45 | 65.21 |
| Devil's Ivy | 15.25 | 64.70 |
| Bamboo | 15.25 | 64.28 |
| Cactus | 15 | 63.82 |
| Pilea Peperomioides | 20.5 | 63.63 |
| ZZ Plant | 25 | 61.81 |
| Orchid | 50.75 | 61.81 |
| Alocasia Polly | 95 | 61.76 |
| Calathea Makoyana | 40.25 | 61.36 |
| Bird of Paradise | 65 | 60.00 |
| Majesty Palm | 70 | 60.00 |
| Dragon Tree | 50.25 | 59.18 |
| Ficus | 20.25 | 59.18 |
| Money Tree | 30.5 | 59.09 |
| Monstera | 50.75 | 58.13 |
| Birds Nest Fern | 15.5 | 57.89 |
| Boston Fern | 20 | 57.77 |
| Pink Anthurium | 60.95 | 57.40 |
| Spider Plant | 15 | 57.14 |
| Peace Lily | 60.5 | 56.25 |
| Fiddle Leaf Fig | 85.5 | 56.00 |
| Angel Wings Begonia | 95 | 53.33 |
| Snake Plant | 25.5 | 51.78 |
| Ponytail Palm | 80.75 | 50.90 |
| Pothos | 30.5 | 46.66 |

The following model builds the result.

```
greenery/models/staging/postgres/stg_conversion_rate_by_product.sql
```

### Part 2

The following macros were created and used in the project.

```
 greenery/macros/unique_purchase_sessions.sql
 greenery/macros/unique_purchases.sql
 greenery/macros/unique_sessions.sql 
 ```

### Part 3

The grant macro ` greenery/macros/grant.sql` was created and used as a post-hook in `greenery/dbt_project.yml`

### Part 4

The `dbt-labs/dbt_utils` package is imported and the `dbt_utils.log()` function is used to log after grant is applied in `greenery/macros/grant.sql` macro.

### Part 5

Created a DAG with `dbt docs serve`. 

### Part 6

The following table lists the products that's changed from week 2.

| PRODUCT\_ID | NAME | PRICE |
| :--- | :--- | :--- |
| fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80 | String of pearls | 80.5 |
| be49171b-9f72-4fc9-bf7a-9a52e259836b | Monstera | 50.75 |
| 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3 | Philodendron | 45 |
| 4cda01b9-62e2-46c5-830f-b7f262a58fb1 | Pothos | 30.5 |
| b66a7143-c18a-43bb-b5dc-06bb5d1d3160 | ZZ Plant | 25 |
| 689fb64e-a4a2-45c5-b9f2-480c2155624d | Bamboo | 15.25 |

This was produced with the following sql query after running `dbt snapshot`

```sql
select product_id, name, price
from DEV_DB.DBT_PBASHYALNMDPORG.INVENTORY_SNAPSHOT
where DBT_VALID_FROM >= date('2024-04-01')
order by price desc ;
```


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
