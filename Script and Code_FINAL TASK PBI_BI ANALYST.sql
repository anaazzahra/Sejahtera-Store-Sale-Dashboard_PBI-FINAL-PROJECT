select * from orders o 

select * from products p 

select ProdNumber from final.products p 

select * from productcategory 

select * from customers  

 select CustomerEmail as cust_email, 
	CustomerCity as cust_city,
	orders.Date as order_date,
	orders.Quantity as order_qty,
	ProdName as product_name,
	Price as product_price,
	CategoryName as category_name,
	sum(Quantity * Price) as total_sales
	from final.customers
join final.orders on final.orders.CustomerID = final.customers.CustomerID
join final.products on final.products.ProdNumber = final.orders.ProdNumber
join final.productcategory on final.productcategory.CategoryID = final.products.Category
group by cust_email
order by cust_email asc;
  
#jawaban no.3
select distinct orders.Date as order_date,
	CategoryName as category_name,
	ProdName as product_name,
	Price as product_price,
	orders.Quantity as order_qty,
	(Quantity * Price) as total_sales,
	CustomerEmail as cust_email, 
	CustomerCity as cust_city
from final.customers
join final.orders on final.orders.CustomerID = final.customers.CustomerID
join final.products on final.products.ProdNumber = final.orders.ProdNumber
join final.productcategory on final.productcategory.CategoryID = final.products.Category
order by order_date asc;

#SELECT customers.CustomerEmail AS cust_email, 
       #customers.CustomerCity AS cust_city,
       #orders.Date AS order_date
#FROM final.customers
#JOIN final.orders ON customers.CustomerID = orders.CustomerID
#group by order_date
#order by  order_date asc;

#Home Work MNC BI Analyst Rakamin
#01
select * from birakamin.superstore_order
where `Ship Mode` = 'Same Day' and `Ship Date` > `Order Date` 
order by `Order Date` asc;

select 
	count(so.`Ship Mode`) as total_terlambat
from birakamin.superstore_order so 
where `Ship Mode` = 'Same Day' and `Ship Date` > `Order Date` 
order by `Order Date` asc;

#02
select 
	case 
		when so.Discount >= 0.4 then 'High'
		when so.Discount > 0.1 and so.Discount < 0.4 then 'Moderat'
		else 'Low'
	end as level_discount,
	avg(Profit) as avg_profit
from birakamin.superstore_order so 
group by level_discount
order by avg_profit asc;

#03
select * from birakamin.superstore_product sp;
select * from birakamin.superstore_order so ;
select 	
	sp.Category ,
	sp.`Sub-Category`,
	avg(Discount) as avg_discount,
	avg(Profit) as avg_profit
from birakamin.superstore_product sp 
join birakamin.superstore_order so on so.`Product ID` = sp.`Product ID`
group by 
	sp.Category, 
	sp.`Sub-Category` 
order by avg_profit asc; 

#04
-- select * from birakamin.superstore_customer sc;
select 
	sc.Segment,
	sc.State,
	sum(Sales) as sum_sales,
	avg(Profit) as avg_profit
from birakamin.superstore_customer sc 
left join birakamin.superstore_order so on so.`Customer ID` = sc.`Customer ID` 
where 
	so.`Order Date` >= '2016-01-01' and so.`Order Date` <= '2016-12-31'
	and sc.State in('California', 'Texas', 'Georgia')
group by 
	sc.Segment,
	sc.State
order by sc.Segment asc;

#05
-- select * from birakamin.superstore_customer sc;
select 
	sc.Region,
	count(distinct sc.`Customer ID`) as total_cust,
	avg(Discount) as avg_discount
from birakamin.superstore_customer sc 
left join birakamin.superstore_order so on so.`Customer ID` = sc.`Customer ID` 
group by 
	sc.Region
order by avg_discount asc;

#05
select distinct 
	sc.`Customer ID`,
	sc.Region, 
	avg(Discount) as avg_discount
from birakamin.superstore_customer sc 
left join birakamin.superstore_order so on so.`Customer ID` = sc.`Customer ID` 
group by 
	sc.`Customer ID`,
	sc.Region
order by avg_discount desc;

select * from
(
	select  
		sc.Region,	
		-- sc.`Customer ID`, 
		avg(so.Discount) as avg_discount
	from 
		birakamin.superstore_customer sc 
	left join 
		birakamin.superstore_order so on so.`Customer ID` = sc.`Customer ID` 
	group by 
		sc.Region
) subq
where avg_discount >= 0.4;

-- having 
	-- avg(so.Discount) >= 0.4;
-- order by discount_tinggi desc;

SELECT
    COALESCE(sc.Region, 'Tidak Diketahui') AS Region,
    COUNT(DISTINCT sc.`Customer ID`) AS discount_tinggi
FROM
    birakamin.superstore_customer sc
LEFT JOIN
    birakamin.superstore_order so ON so.`Customer ID` = sc.`Customer ID`
GROUP BY
    COALESCE(sc.Region, 'Tidak Diketahui')
HAVING
    AVG(COALESCE(so.Discount, 0)) >= 0.4;
