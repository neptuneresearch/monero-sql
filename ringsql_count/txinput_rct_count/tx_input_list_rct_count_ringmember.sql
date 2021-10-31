-- Count transaction inputs in current ring-membership-sql data
CREATE MATERIALIZED VIEW tx_input_list_rct_count_ringmember AS (
	SELECT 
		block_height,
		tx_index,
		vin_index,
		COUNT(*) AS n_vin_key_offset
	FROM tx_input_list
    WHERE vin_amount = 0
	GROUP BY 
		block_height,
		tx_index,
		vin_index
) WITH NO DATA;

REFRESH MATERIALIZED VIEW tx_input_list_rct_count_ringmember;