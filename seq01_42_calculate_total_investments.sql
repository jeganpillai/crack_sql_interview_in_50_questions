-- Question: Calculate Total Investments value for the year 2024

-- English Video: 
-- Tamil Video: 

Create Table Insurance (pid int, tiv_2023 float, tiv_2024 float, lat float, lon float);
Truncate table Insurance;
insert into Insurance (pid, tiv_2023, tiv_2024, lat, lon) values 
 (1, 10,  5, 10, 10)
,(2, 20, 20, 20, 20)
,(3, 10, 30, 20, 20)
,(4, 10, 40, 40, 40);

-- Approach 1: Using Subquery and Correlated Subquery 
select round(sum(src.tiv_2024),2) as tiv_2024 
      from Insurance src 
     where src.tiv_2023 in (select tiv_2023 from Insurance group by 1 having count(*) > 1)
       and 1 = (select count(pid) from Insurance i where i.lat = src.lat and i.lon = src.lon);

-- Approach 2: Using Correlated Subquery filtering
select round(sum(src.tiv_2024),2) as tiv_2024
      from Insurance src 
     where 1 < (select count(pid) from Insurance i where i.tiv_2023 = src.tiv_2023)
       and 0 = (select count(pid) from Insurance i where i.pid <> src.pid and i.lat = src.lat and i.lon = src.lon);

