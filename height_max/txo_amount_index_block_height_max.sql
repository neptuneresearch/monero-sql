CREATE VIEW txo_amount_index_block_height_max AS 
    SELECT block_height 
    FROM txo_amount_index
    ORDER BY block_height DESC 
    LIMIT 1;