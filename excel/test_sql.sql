create database Test1;

use Test1;
-- Determine the conversion volume achieved by each marketing channel

select a.Channel,sum(b.conversions) as con
from marketingcamp as a
join user_engagement1 as b
on a.Campaign_ID = b.campaign_ID
group by a.channel
order by con;

-- Calculate each campaign’s return by comparing spending to revenue.
with TOT1 AS (
select a.campaign_ID, (a.New_User_Revenue+a.Returning_User_Revenue) as total_revenue,b.budget 
from revenue as a join marketingcamp as b on a.Campaign_ID = B.Campaign_ID )
SELECT 
    Campaign_ID,
  (tot1.total_revenue)/
    Budget as returnf
    FROM tot1
    ;
    
    
CREATE TABLE TOT AS 
select a.campaign_ID, (a.New_User_Revenue+a.Returning_User_Revenue) as total_revenue from revenue as a ;

SELECT * FROM totalr1;

 


-- Combine All Campaign Data.
create table consolidatedT AS select a.*,b.New_User_Revenue,b.Returning_User_Revenue,c.Impressions,c.clicks,c.Sign_Ups,c.Conversions from
marketingcamp as a join revenue as b 
on a.Campaign_ID = b.Campaign_ID
join user_engagement1 as c on 
b.Campaign_ID = c.Campaign_ID;

Select * from consolidatedT

-- Highlight High-Return Campaigns.
-- Identify campaigns exceeding average returns with nested calculations.
CREATE TABLE TOTALR1 AS 
select a.campaign_ID, a.New_User_Revenue+a.Returning_User_Revenue as total_revenue from revenue as a ;

select * from TOTALR1;
create table new as select a.* ,b.channel,b.start_date from 
TOTALR1 as a join
marketingcamp as b
on a.Campaign_ID = b.Campaign_ID ;

SELECT 
    Campaign_ID,total_revenue,
     CASE 
        WHEN total_Revenue > ( select AVG(total_revenue) from TOTALR1 ) THEN 'Yes' 
        ELSE 'No' 
    END AS ExceedsAvgReturn
FROM TOTALR1;

-- Display cumulative revenue by channel ordered by campaign start date.

select a.channel,a.start_date,SUM(b.TOTAL_REVENUE) OVER(PARTITION BY a.Channel order by a.start_date desc) as cumrev from
 marketingcamp as a
join TOTALR1 as b
on a.Campaign_ID = b.Campaign_ID;



