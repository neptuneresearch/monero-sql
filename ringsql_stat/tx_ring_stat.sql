-- For every transaction of every block, list the ring size or sizes.
-- Almost every transaction on-chain has the same ring size, "ring_size", among all inputs;
--   HF v8 fixed the ring size to 11, but this was also true before HF v8.
-- Only 2478 transactions within blocks 3003-1118879 have inputs of different ring sizes, "ring_sizes_[p]rct".
-- "ring_size" and "ring_sizes_[p]rct" are mutually exclusive; unused columns will be NULL.
CREATE MATERIALIZED VIEW tx_ring_stat AS (
    SELECT 
        S.block_height,
        S.tx_index,
        S.tx_hash,
        COUNT(*) FILTER (WHERE S.is_rct = FALSE) AS n_prct_rings,
        COUNT(*) FILTER (WHERE S.is_rct = TRUE) AS n_rct_rings,
        CASE WHEN COUNT(DISTINCT S.ring_size) = 1
                -- Since there is only 1 distinct size, every size is the maximum;
                --   this aggregate is only intended to pass-through the singular value.
                THEN MAX(S.ring_size)
                ELSE NULL
            END AS ring_size,
        CASE WHEN COUNT(DISTINCT S.ring_size) > 1
                THEN ARRAY_AGG(DISTINCT ring_size ORDER BY ring_size) FILTER (WHERE S.is_rct = FALSE)
                ELSE NULL
            END AS ring_sizes_prct,
        CASE WHEN COUNT(DISTINCT S.ring_size) > 1
                THEN ARRAY_AGG(DISTINCT ring_size ORDER BY ring_size) FILTER (WHERE S.is_rct = TRUE)
                ELSE NULL
            END AS ring_sizes_rct
    FROM tx_input_ring_stat S
    GROUP BY S.block_height, S.tx_index, S.tx_hash
    ORDER BY S.block_height ASC, S.tx_index ASC
) WITH NO DATA;

-- Runtime @H=2508299: 2m35s
REFRESH MATERIALIZED VIEW tx_ring_stat;

-- Runtime @H=2508299: 16s
CREATE INDEX tx_ring_stat_tx_hash ON tx_ring_stat (tx_hash);