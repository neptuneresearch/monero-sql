-- Count transactions in current ring-membership-sql data
-- Runtime: 3m40s
CREATE VIEW tx_input_list_rct_count_tx AS
	WITH one_per_tx AS (
		SELECT 1 AS n
		FROM tx_input_list
		-- Transaction is counted if it has at least one RingCT input 
		WHERE vin_amount = 0
		-- "per tx" keys
		GROUP BY block_height, tx_index, tx_hash 
	)
	SELECT SUM(one.n)
	FROM one_per_tx one;