-- Count transactions in current ring-membership-sql data
CREATE MATERIALIZED VIEW tx_input_list_rct_count_tx AS (
	WITH one_per_tx AS (
		SELECT 1 AS n
		FROM tx_input_list
		-- Transaction is counted if it has at least one RingCT input 
		WHERE vin_amount = 0
		-- "per tx" keys
		GROUP BY block_height, tx_index, tx_hash 
	)
	SELECT SUM(one.n) AS n_tx
	FROM one_per_tx one
) WITH NO DATA;

-- Runtime @H=2576199: 4m53s
REFRESH MATERIALIZED VIEW tx_input_list_rct_count_tx;