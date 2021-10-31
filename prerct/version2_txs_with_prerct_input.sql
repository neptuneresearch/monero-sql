SELECT *
FROM monero block,
LATERAL unnest(block.transactions) tx,
LATERAL unnest(tx.vin) vin
WHERE
	block.height > 1400000
	AND tx."version" = 2
	AND vin.amount <> 0
ORDER BY block.height DESC;