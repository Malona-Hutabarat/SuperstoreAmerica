# SuperstoreAmerica

### **1. Select Data** 
Sub_Category, Category, Region, State, City, Segment, Sales, Quantity, Discount, Profit,
Sub_Category, Category, Region, State, City, Segment
### **2. Convert Date** 
* yyyy-mm-dd :  day, month, and year
* Data: Date_Order, Ship_Order
* Calculate Delivery Date : Ship_Date - Order_Date
### **3. Save Data to Store America**

```RUBY
select 
	Sub_Category, Category, Region, State, City, Segment, Sales, Quantity, Discount, Profit,
	Order_Date, day(Order_Date) as Order_day, month(Order_Date) as Order_Month,year(Order_Date) as Oder_Year,
	Ship_Date, day(Ship_Date) as Ship_day,
	(datediff(dd, Order_Date, Ship_Date) + 1) - datediff(ww, Order_Date, Ship_Date)*2 as  Delivery_Day
	into StoreAmerica
from [dbo].[Orders$]
order by City asc
```
| Sub_Category | Category        | Region  | State        | City     | Segment   | Sales   | Quantity | Discount | Profit   | Order_Date              | Order_day | Order_Month | Oder_Year | Ship_Date               | Ship_day | Delivery_Day |
|--------------|-----------------|---------|--------------|----------|-----------|---------|----------|----------|----------|-------------------------|-----------|-------------|-----------|-------------------------|----------|--------------|
| Supplies     | Office Supplies | Central | South Dakota | Aberdeen | Consumer  | 25,5    | 3        | 0        | 6,63     | 2017-11-11 00:00:00.000 | 11        | 11          | 2017      | 2017-11-14 00:00:00.000 | 14       | 2            |
| Appliances   | Office Supplies | Central | Texas        | Abilene  | Consumer  | 1,392   | 2        | 0,8      | -3,7584  | 2017-12-11 00:00:00.000 | 11        | 12          | 2017      | 2017-12-13 00:00:00.000 | 13       | 3            |
| Paper        | Office Supplies | East    | Ohio         | Akron    | Corporate | 85,056  | 3        | 0,2      | 28,7064  | 2017-09-10 00:00:00.000 | 10        | 9           | 2017      | 2017-09-13 00:00:00.000 | 13       | 4            |
| Phones       | Technology      | East    | Ohio         | Akron    | Corporate | 259,896 | 2        | 0,4      | -56,3108 | 2016-08-14 00:00:00.000 | 14        | 8           | 2016      | 2016-08-18 00:00:00.000 | 18       | 5            |
| Phones       | Technology      | East    | Ohio         | Akron    | Corporate | 247,188 | 2        | 0,4      | -49,4376 | 2016-08-14 00:00:00.000 | 14        | 8           | 2016      | 2016-08-18 00:00:00.000 | 18       | 5            |
