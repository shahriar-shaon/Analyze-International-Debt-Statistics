-- Table: international_debt

CREATE TABLE international_debt
(
  country_name character varying(50),
  country_code character varying(50),
  indicator_name text,
  indicator_code text,
  debt numeric
);

-- Copy over data from CSV
\copy international_debt FROM 'international_debt.csv' DELIMITER ',' CSV HEADER;


##
SELECT 
    *
FROM
    international_debt
LIMIT 10;

## count distinct country##
SELECT 
    COUNT(DISTINCT country_name) AS Tota_Distinct_Country
FROM
    international_debt;
## Finding out the distinct debt indicators##
SELECT DISTINCT
    (indicator_code) AS distinct_debt_indicators
FROM
    international_debt
ORDER BY distinct_debt_indicators;

## Totaling the amount of debt owed by the countries##

SELECT 
    round(sum(debt)/1000000, 2) as total_debt
FROM international_debt; 

## Country with the highest debt (10)##
SELECT 
   country_name,
    sum(debt) as total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt desc
limit 10;

## Average amount of debt across indicators##

SELECT 
    indicator_code AS debt_indicator,
   indicator_name,
  avg(debt) as average_debt
FROM international_debt
GROUP BY debt_indicator, indicator_name
ORDER BY average_debt desc
limit 10;

## The highest amount of principal repayments ##

SELECT 
   country_name, 
  indicator_name
FROM international_debt
WHERE debt = (SELECT 
                 max(debt)
             FROM international_debt
              where indicator_code = 'DT.AMT.DLXF.CD');


## The most common debt indicator ##

select indicator_code, 
count(indicator_code) as indicator_count
from international_debt

group by indicator_code

order by indicator_count desc, indicator_code desc

limit 10;

### the maximum amount of debt that each country owes #

select country_name, max(debt) as maximum_debt

from international_debt

group by country_name

order by maximum_debt desc

limit 10;

