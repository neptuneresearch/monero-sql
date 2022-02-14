-- For each transaction input of every transaction of every block, list:
-- - is_rct, BOOLEAN: TRUE if RingCT, FALSE if pre-RingCT
-- - ring_size, INTEGER: ring size
CREATE MATERIALIZED VIEW tx_input_ring_stat AS
    SELECT 
        block_height,
        tx_index,
        tx_hash,
        vin_index,
        CAST(CASE WHEN vin_amount = 0 THEN TRUE ELSE FALSE END AS BOOLEAN) AS is_rct,
        CAST(COUNT(vin_key_offset_index) AS INTEGER) AS ring_size
    FROM tx_input_list 
    GROUP BY block_height, tx_index, tx_hash, vin_index, vin_amount
    ORDER BY block_height ASC, tx_index ASC, vin_index ASC
WITH NO DATA;

-- Runtime @H=2508299: 7m
REFRESH MATERIALIZED VIEW tx_input_ring_stat;