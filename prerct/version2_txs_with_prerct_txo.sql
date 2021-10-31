-- Not possible: if tx.version = 2, then output amount = 0
SELECT 
	vout.amount,
	COUNT(1)
FROM monero block,
LATERAL UNNEST (block.transactions) tx,
LATERAL UNNEST (tx.vout) vout
WHERE 
	block.height >= 1220516
	AND tx."version" = 2
GROUP BY vout.amount;