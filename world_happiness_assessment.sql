/*
Question 1 : Create a new table CountryStats with columns Country,
 Region, and HappinessRank. Include a primary key. 
 
 CREATE TABLE CountryStats (
    Country VARCHAR(255),
    Region VARCHAR(255),
    HappinessRank INT,
    PRIMARY KEY (Country)
);

Question 2: Write a query to insert data into CountryStats from the happiness table. 

/// Basic Inset into data comand i assumed the happiness table was 2015 table

INSERT INTO CountryStats (Country, Region, HappinessRank)
SELECT Country, Region, HappinessRank
FROM `2015`;

Question 3: Create a view TopHappiness that shows the top 10 happiest countries. 
tophappiness
CREATE VIEW TopHappiness AS
SELECT 
    Country,
    Region,
    `Happiness Rank`,
    `Happiness Score`
FROM
    `2015`
ORDER BY `Happiness Score` DESC
LIMIT 10;

Question 4:How would you join happiness and CountryStats tables to display the Country,
 Region, and HappinessRank where the HappinessScore is above 7? 
 
 //This statement selects specific columns from two tables, hs and cs. It retrieves:

The Country column from the hs table.
The Region column from the cs table.
The Happiness Rank column from the cs table, and it assigns an alias HappinessRank to this column.
 
SELECT * FROM TopHappiness;

SELECT 
    hs.Country,
    cs.Region,
    cs.`Happiness Rank` AS HappinessRank
FROM 
    `2015` hs
JOIN 
    CountryStats cs ON hs.Country = cs.Country
WHERE 
    hs.`Happiness Score` > 7;

Question 5: Write a query to update CountryStats with a new column EconomyScore,
and populate it from the happiness table. 
    
// first i used alter table to create an empty column
//then use a join to join `2015` table to cs table populate it with Economy (GDP per Capita)
ALTER TABLE CountryStats
ADD COLUMN EconomyScore FLOAT

UPDATE CountryStats cs
JOIN `2015` hs ON cs.Country = hs.Country
SET cs.EconomyScore = hs.`Economy (GDP per Capita)`;

Question 6: How can you create an index on the HappinessRank column of the CountryStats table? 

CREATE INDEX idx_HappinessRank ON CountryStats (`HappinessRank`);

Question 7: Write a query that uses a window function to rank countries within
 each region based on their HappinessScore

SELECT
    Country,
    Region,
    `Happiness Score`,
    RANK() OVER (PARTITION BY Region ORDER BY `Happiness Score` DESC) AS RegionRank
FROM
    `2015`;
    
Question 8:
How would you find the average HappinessScore for each region, including only countries with a 
Generosity score above the regional average? 


SELECT
    Region,
    AVG(HappinessScore) AS AvgHappinessScore
FROM (
    SELECT
        Region,
        Country,
        `Happiness Score` AS HappinessScore,
        Generosity,
        AVG(Generosity) OVER (PARTITION BY Region) AS AvgGenerosity
    FROM
        `2015`
) AS subquery
WHERE
    Generosity > AvgGenerosity
GROUP BY
    Region;
    
    
Question 9

SELECT
    h1.Country,
    h1.Region,
    h1.`Trust (Government Corruption)`
FROM
    `2015` h1
JOIN (
    SELECT
        Region,
        AVG(`Trust (Government Corruption)`) AS AvgTrust
    FROM
        `2015`
    GROUP BY
        Region
) h2 ON h1.Region = h2.Region
WHERE
    h1.`Trust (Government Corruption)` > h2.AvgTrust;
    
Question 10: How would you alter the CountryStats table to add a foreign key
 constraint referencing the happiness table? 
 
 
Question 11: Write a query to list all the countries and their Happiness Score,
 along with the average happiness score of their region. 
 
 SELECT
    h1.Country,
    h1.`Happiness Score`,
    h2.AvgRegionHappinessScore
FROM
    `2015` h1
JOIN (
    SELECT
        Region,
        AVG(`Happiness Score`) AS AvgRegionHappinessScore
    FROM
        `2015`
    GROUP BY
        Region
) h2 ON h1.Region = h2.Region;

 
Question 12:Create a stored procedure UpdateHappinessRank that updates the HappinessRank in CountryStats
 based on a given Country and NewRank. 
 DELIMITER //

CREATE PROCEDURE UpdateHappinessRank (
    IN p_Country VARCHAR(255),
    IN p_NewRank INT
)
BEGIN
    UPDATE CountryStats
    SET HappinessRank = p_NewRank
    WHERE Country = p_Country;
END //

DELIMITER ;

CALL UpdateHappinessRank('CountryName', 10);
 
Question 13:How would you write a query to find the top 5 regions
 with the highest average Generosity score? 
 
 SELECT
    Region,
    AVG(Generosity) AS AvgGenerosity
FROM
    `2015`
GROUP BY
    Region
ORDER BY
    AvgGenerosity DESC
LIMIT 5;
 
 Question 14:Write a query to select countries that have improved their HappinessRank by more
 than 10 places between 2015 and 2019. 
 SELECT
    a.Country,
    a.`Happiness Rank` AS Rank2015,
    b.`Overall rank` AS Rank2019,
    b.`Overall rank` - a.`Happiness Rank` AS RankDifference
FROM
    `2015` a
JOIN
    `2019` b ON a.Country = b.`Country or region`
WHERE
    b.`Overall rank` - a.`Happiness Rank` > 10;
 
 
 Question 15:How would you use a CTE (Common Table Expression) to list countries
 where the Health (Life Expectancy) is above the global average? 
 
 WITH GlobalHealthAverage AS (
    SELECT AVG(`Health (Life Expectancy)`) AS AvgHealth
    FROM `2015`
)
SELECT Country
FROM `2015`, GlobalHealthAverage
WHERE `Health (Life Expectancy)` > GlobalHealthAverage.AvgHealth;
 
    */
    



