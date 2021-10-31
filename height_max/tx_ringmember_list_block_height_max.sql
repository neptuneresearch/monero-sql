CREATE VIEW tx_ringmember_list_block_height_max AS
    SELECT tx_block_height 
    FROM tx_ringmember_list 
    ORDER BY tx_block_height DESC LIMIT 1;