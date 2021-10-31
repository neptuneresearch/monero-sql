CREATE VIEW monero_height_max AS 
    SELECT height 
    FROM monero 
    ORDER BY height DESC 
    LIMIT 1;