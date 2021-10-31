-- Leverages shortcut: the max Amount Index is a 0-based count of all RCT outputs.
CREATE VIEW txo_amount_index_count_ringct_txo AS
	SELECT amount_index + 1 AS amount_index_max_1based -- Add 1 to get 1-based count because amount_index starts at 0
	FROM txo_amount_index 
	WHERE txo_amount = 0 -- RingCT
	ORDER BY amount_index DESC 
	LIMIT 1;