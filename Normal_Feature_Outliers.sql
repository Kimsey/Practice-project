-- Columns to check: Total Spend, Items Purchased, Average Rating, Discount Applied, Days Since Last Purchase, Satisfaction Level
SELECT * FROM
(
    SELECT 
    -- get all columns
        `Customer ID`,
        Gender,
        Age, 
        City,
        `Membership Type`,
        `Total Spend`, 
        `Items Purchased`,
        `Average Rating`, 
        `Discount Applied`,
        `Days Since Last Purchase`,
        `Satisfaction Level`,
        (`Total Spend` / `Items Purchased`) AS Spend_Per_Item,
        CASE 
			WHEN `Days Since Last Purchase` > 35 THEN 1
            ELSE 0
		END AS Churn,
	-- Get rid outlier value of all numeric columns
		(Age - avg(Age) OVER()) / STDDEV(Age) OVER() AS S_Age,
        (`Total Spend` - avg(`Total Spend`) OVER()) / STDDEV(`Total Spend`) OVER() AS S_TotalSpend,
        (`Items Purchased` - avg(`Items Purchased`) OVER()) / STDDEV(`Items Purchased`) OVER() AS S_ItemsPurchased,
        (`Average Rating` - avg(`Average Rating`) OVER()) / STDDEV(`Average Rating`) OVER() AS S_AverageRating,
        (`Days Since Last Purchase` - avg(`Days Since Last Purchase`) OVER()) / STDDEV(`Days Since Last Purchase`) OVER() AS S_DaysSinceLastPurchase
    FROM commerce
) as Tabl30
-- Keep the rows that don't have any outliers
WHERE 
    S_Age < 1.96 AND S_Age > -1.96 AND
    S_TotalSpend < 1.96 AND S_TotalSpend > -1.96 AND
    S_ItemsPurchased < 1.96 AND S_ItemsPurchased > -1.96 AND
    S_AverageRating < 1.96 AND S_AverageRating > -1.96 AND
    S_DaysSinceLastPurchase < 1.96 AND S_DaysSinceLastPurchase > -1.96;

    