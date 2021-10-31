-- Count transactions, per HF version, in current ring-membership-sql data
CREATE MATERIALIZED VIEW tx_input_list_rct_count_tx_version AS (
    WITH subquery AS (
        SELECT DISTINCT
            block_height,
            tx_index
        FROM tx_input_list
        -- Transaction is counted if it has at least one RingCT input
        WHERE vin_amount = 0
    )
    SELECT
        V0."version" AS "version",
        V0."height" AS "height",
        COUNT(S.tx_index) AS n_tx
    FROM monero_version V
    JOIN monero_version V0 ON V0."version" = V."version" - 1
    JOIN subquery S ON S.block_height >= V0."height" AND S.block_height < V."height"
    GROUP BY V0."version", V0."height"
    ORDER BY V0."height", V0."height"
) WITH NO DATA;

-- Runtime: 5m
REFRESH MATERIALIZED VIEW tx_input_list_rct_count_tx_version;