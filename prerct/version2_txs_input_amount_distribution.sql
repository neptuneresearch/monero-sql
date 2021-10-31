SELECT
	vin.amount,
	COUNT(1)
FROM
	monero block,
	LATERAL UNNEST (block.transactions) tx,
	LATERAL UNNEST (tx.vin) vin
WHERE
	block.height >= 1220516
	AND tx."version" = 2
GROUP BY vin.amount
ORDER BY vin.amount ASC;