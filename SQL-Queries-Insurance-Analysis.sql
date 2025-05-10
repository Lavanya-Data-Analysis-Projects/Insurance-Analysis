create database insurance;
use insurance;

select * from brokerage1;
select * from budget;
select * from invoice;
select * from fees;
select * from meetings1;


-- Kpi 1 -- No of invoices By Account Executive ---

select count(invoice_number) as no,Account_Executive from invoice group by Account_Executive order by no desc;

-- Kpi 2 -- yearly meeting count---

select year(meetings_date) as year ,count(*) Account_Executive  from meetings1 group by year;
 

-- Kpi 3 -- Cross Sell - Target,Achieved,InvoiceCross Sell 
select(
(select sum(Cross_sell_budget) from budget))as TargetCrossSell,
(select sum(Amount) from brokerage1 where income_class ="Cross Sell") +
(select sum(Amount) from fees where income_class="Cross Sell")  as CrossSellAcheived,
(select sum(Amount) from invoice where income_class="Cross Sell" )as InvoiceCrossSell;

 
-- Kpi3 New Sell Target,Acheived,invoice
select(
(select sum(New_budget)from budget))as TargetNew,
(select sum(Amount) from brokerage1 where income_class ="New") +
(select sum(Amount) from fees where income_class="New")  as NewSellAcheived,
(select sum(Amount) from invoice where income_class="New" )as InvoiceNewSell;

-- Kpi 3 -- Renewal Sell- Target,Acheived,InvoiceRenewal
select(
(select sum(Renewal_budget) from budget))as TargetRenewalSell,
(select sum(Amount) from brokerage1 where income_class ="Renewal") +
(select sum(Amount) from fees where income_class="Renewal")  as RenewalSellAcheived,
(select sum(Amount) from invoice where income_class="Renewal" )as InvoiceRenewalSell;


-- Kpi 3 -- Cross Sell,new sell ,Renewal Placed Acheivement percentage ---

select ((
select sum(Amount) from brokerage1 where income_class="Cross Sell")+
(select sum(Amount) from fees where income_class="Cross Sell")) /(select sum(Cross_sell_budget) from budget )*100 as CrossSellPlacedAcheivement,
((select sum(Amount) from brokerage1 where income_class="New") +
(select sum(Amount) from fees where income_class="New"))/(select sum(New_budget) from budget)*100 as NewSellPlacedAcheivement,
((select sum(Amount) from brokerage1 where income_class="Renewal") +
(select sum(Amount) from fees where income_class="Renewal")) /(select sum(Renewal_budget) from budget )*100 as RenewalPlacedAcheivement;


-- Kpi 3 --  cross Sell ,new Sell,Renewal invoice Acheivemnet percentage--
select (
select sum(Amount) from invoice where income_class="Cross Sell")/(select sum(Cross_sell_budget) from budget )*100 as CrossSellinvoiceAcheivement,
(select sum(Amount) from invoice where income_class="New")/(select sum(New_budget) from budget)*100 as NewSellinvoiceAcheivement,
(select sum(Amount) from invoice where income_class="Renewal")/(select sum(Renewal_budget) from budget )*100 as RenewalinvoiceAcheivement;


-- Kpi 4 -- Stage Funnel By Revenue ---
select stage,sum(revenue_amount) as revenue_amount from oppurtunity group by stage;

-- Kpi 5 -- No Of meetings By Account Execeutive --
select Account_Executive ,count(meetings_date) as no_of_meetings from meetings1 group by Account_Executive;

-- Kpi 6 -- Top Open Oppurtunity --

-- Kpi 6 -- Top 4 open revenue --
select opportunity_name,sum(revenue_amount) as revenue_amount from oppurtunity group by opportunity_name order by revenue_amount desc limit 4;

-- kpi 6 -- Top 4 Open Oppty
select opportunity_name,sum(revenue_amount) as revenue_amount from oppurtunity 
where stage ="Qualify Opportunity" or "Propose Solution"group by opportunity_name order by revenue_amount desc limit 4;

-- kpi 6 -- Oppty Product distribution---
select count(opportunity_id) as oppurtunity ,product_group from oppurtunity group by product_group order by oppurtunity desc;




