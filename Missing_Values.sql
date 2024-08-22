# No need for imputation because no missing values
SELECT
    COUNT('Customer ID'),
    COUNT(Gender),
    COUNT(Age),
    COUNT(City),
    COUNT('Membership Type'),
    COUNT('Total Spend'),
    COUNT('Items Purchased'),
    COUNT('Average Rating'),
    COUNT('Discount Applied'),
    COUNT('Days Since Last Purchase'),
    COUNT('Satisfaction Level')
FROM commerce;