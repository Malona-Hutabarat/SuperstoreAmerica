select * from [dbo].[Orders$] --- The Raw Data

--- Extract Data that will be used and save
select 
	Sub_Category, Category,  Ship_Mode, Region, State, City, Segment, Sales, Quantity, Discount, Profit,
	Order_Date, day(Order_Date) as Order_day, month(Order_Date) as Order_Month,year(Order_Date) as Oder_Year,
	Ship_Date, day(Ship_Date) as Ship_day,
	(datediff(dd, Order_Date, Ship_Date) + 1) - datediff(ww, Order_Date, Ship_Date)*2 as  Delivery_Day
	into Newdata
from [dbo].[Orders$]
order by City asc

--- Select data from New Store
select * from Newdata

---What is the Sub_Category with the most sales?
select
	Sub_Category, sum(Sales) Sales
from Newdata
group by Sub_Category
order by Sales desc

---What is the year with the most sales?
select
	Oder_Year, sum(Sales) Sales
from Newdata
group by Oder_Year
order by Sales desc

---What is the Ship_Mode with the most sales?
select
	Ship_Mode, sum(Sales) Sales
from Newdata
group by Ship_Mode
order by Sales desc


---What are the highest sales in any month of the year?
select
	Order_Month, sum (Sales) Sales, count(Quantity) Quantity
from Newdata
where Oder_Year = 2017
group by Order_Month
order by  2 desc

---What are the best selling Sub_Categories in November 2017?
select
	Order_Month, Sub_Category, sum (Sales) Sales, count(Quantity) Quantity
from Newdata
where Oder_Year = 2017 and Order_Month=11
group by Order_Month, Sub_Category
order by  3 desc

--- How long does it take for delivery of Sub_Category to various states, city, and regions?
select
	Region, State, City, Ship_Mode, Sub_Category,Delivery_Day, sum (Sales) Sales
from Newdata
group by Region, State, City, Ship_Mode, Sub_Category, Delivery_Day
order by  Sales desc 
