# SuperstoreAmerica

### **1. Select Data** 
#### [The Raw Data](https://github.com/Malona-Hutabarat/SuperstoreAmerica/blob/main/Superstore.xlsx)
* Sub_Category, Category, Ship_Mode Region, State, City, Segment, Sales, Quantity, Discount, Profit,
Sub_Category, Category, Region, State, City, Segment
### **2. Convert Date** 
* yyyy-mm-dd :  day, month, and year
* Data: Date_Order, Ship_Order
* Calculate Delivery Date : Ship_Date - Order_Date
### **3. Save Data to Newdata**

```RUBY
select 
	Sub_Category, Category,  Ship_Mode, Region, State, City, Segment, Sales, Quantity, Discount, Profit,
	Order_Date, day(Order_Date) as Order_day, month(Order_Date) as Order_Month,year(Order_Date) as Oder_Year,
	Ship_Date, day(Ship_Date) as Ship_day,
	(datediff(dd, Order_Date, Ship_Date) + 1) - datediff(ww, Order_Date, Ship_Date)*2 as  Delivery_Day
	into Newdata
from [dbo].[Orders$]
order by City asc
```
| Sub_Category | Category        | Ship_Mode    | Region  | State        | City     | Segment   | Sales   | Quantity | Discount | Profit   | Order_Date              | Order_day | Order_Month | Oder_Year | Ship_Date               | Ship_day | Delivery_Day |
|--------------|-----------------|--------------|---------|--------------|----------|-----------|---------|----------|----------|----------|-------------------------|-----------|-------------|-----------|-------------------------|----------|--------------|
| Supplies     | Office Supplies | Second Class | Central | South Dakota | Aberdeen | Consumer  | 25,5    | 3        | 0        | 6,63     | 2017-11-11 00:00:00.000 | 11        | 11          | 2017      | 2017-11-14 00:00:00.000 | 14       | 2            |
| Appliances   | Office Supplies | Second Class | Central | Texas        | Abilene  | Consumer  | 1,392   | 2        | 0,8      | -3,7584  | 2017-12-11 00:00:00.000 | 11        | 12          | 2017      | 2017-12-13 00:00:00.000 | 13       | 3            |
| Paper        | Office Supplies | Second Class | East    | Ohio         | Akron    | Corporate | 85,056  | 3        | 0,2      | 28,7064  | 2017-09-10 00:00:00.000 | 10        | 9           | 2017      | 2017-09-13 00:00:00.000 | 13       | 4            |
| Phones       | Technology      | Second Class | East    | Ohio         | Akron    | Corporate | 259,896 | 2        | 0,4      | -56,3108 | 2016-08-14 00:00:00.000 | 14        | 8           | 2016      | 2016-08-18 00:00:00.000 | 18       | 5            |
| Phones       | Technology      | Second Class | East    | Ohio         | Akron    | Corporate | 247,188 | 2        | 0,4      | -49,4376 | 2016-08-14 00:00:00.000 | 14        | 8           | 2016      | 2016-08-18 00:00:00.000 | 18       | 5            |
## Analysist
### 1. What is the Sub_Category with the most sales?
Phones
```Ruby
select
	Sub_Category, sum(Sales) Sales
from Newdata
group by Sub_Category
order by Sales desc
```
| Sub_Category |       Sales      |
|:------------:|:----------------:|
| Phones       |       330007,054 |
| Chairs       | 328449,103000001 |
| Storage      |       223843,608 |
| Tables       |       206965,532 |
| Binders      |       203412,733 |
| Machines     |       189238,631 |
| Accessories  |       167380,318 |
| Copiers      |        149528,03 |
| Bookcases    |      114879,9963 |
| Appliances   |       107532,161 |
| Furnishings  |        91705,164 |
| Paper        | 78479,2060000001 |
| Supplies     |        46673,538 |
| Art          |        27118,792 |
| Envelopes    |        16476,402 |
| Labels       |        12486,312 |
| Fasteners    |          3024,28 |

### 2. What is the year with the most sales?
2017
```RUBY
select
	Oder_Year, sum(Sales) Sales
from Newdata
group by Oder_Year
order by Sales desc
```
| Oder_Year |       Sales      |
|-----------|:----------------:|
| 2017      | 733215,2552      |
| 2016      | 609205,598       |
| 2014      | 484247,498100001 |
| 2015      | 470532,509       |

### 3. What is the Ship_Mode with the most sales?
Standard Class
```Ruby
select
	Ship_Mode, sum(Sales) Sales
from Newdata
group by Ship_Mode
order by Sales desc
```
| Ship_Mode      |       Sales      |
|----------------|:----------------:|
| Standard Class | 1358215,74299998 |
| Second Class   | 459193,5694      |
| First Class    | 351428,422900001 |
| Same Day       | 128363,125       |
### 4. What are the highest sales in any month of the year?
November
```RUBY
select
	Order_Month, sum (Sales) Sales, count(Quantity) Quantity
from Newdata
where Oder_Year = 2017
group by Order_Month
order by  2 desc
```
| Order_Month |    Sales   | Quantity |
|-------------|:----------:|----------|
| 11          | 118447,825 | 459      |
| 9           | 87866,652  | 459      |
| 12          | 83829,3188 | 462      |
| 10          | 77776,9232 | 298      |
| 8           | 63120,888  | 218      |
| 3           | 58872,3528 | 238      |
| 6           | 52981,7257 | 245      |
| 7           | 45264,416  | 226      |
| 5           | 44261,1102 | 242      |
| 1           | 43971,374  | 155      |
| 4           | 36521,5361 | 203      |
| 2           | 20301,1334 | 107      |
### 5. What are the best selling Sub_Categories in November 2017?
Phones
```RUBY
select
	Order_Month, Sub_Category, sum (Sales) Sales, count(Quantity) Quantity
from Newdata
where Oder_Year = 2017 and Order_Month=11
group by Order_Month, Sub_Category
order by  3 desc
```
| Order_Month | Sub_Category | Sales     | Quantity |
|-------------|--------------|-----------|----------|
| 11          | Phones       | 17407,14  | 44       |
| 11          | Chairs       | 14561,218 | 27       |
| 11          | Tables       | 13658,688 | 17       |
| 11          | Copiers      | 12359,936 | 3        |
| 11          | Storage      | 11911,276 | 42       |
| 11          | Machines     | 11761,377 | 6        |
| 11          | Accessories  | 8390,32   | 40       |
| 11          | Appliances   | 6746,07   | 22       |
| 11          | Furnishings  | 6714,122  | 49       |
| 11          | Binders      | 6490,565  | 63       |
| 11          | Paper        | 3620,614  | 63       |
| 11          | Bookcases    | 2122,687  | 6        |
| 11          | Art          | 1387,042  | 40       |
| 11          | Envelopes    | 518,632   | 11       |
| 11          | Supplies     | 451,998   | 6        |
| 11          | Labels       | 207,928   | 11       |
| 11          | Fasteners    | 138,212   | 9        |
