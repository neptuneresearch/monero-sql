-- Count transaction inputs, per HF version, in current ring-membership-sql data
-- Requires: tx_input_list_rct_count_ringmember_version
CREATE MATERIALIZED VIEW tx_input_list_rct_count_ringmember_version AS (
    SELECT
        V0."version" AS "version",
        V0."height" AS "height",
        COUNT(CR.*) AS n_txinputs
    FROM monero_version V
    JOIN monero_version V0 ON V0."version" = V."version" - 1
    JOIN tx_input_list_rct_count_ringmember CR ON CR.block_height >= V0."height" AND CR.block_height < V."height"
    GROUP BY V0."version", V0."height"
    ORDER BY V0."version", V0."height"
) WITH NO DATA;

-- Runtime: 42s
REFRESH MATERIALIZED VIEW tx_input_list_rct_count_ringmember_version;