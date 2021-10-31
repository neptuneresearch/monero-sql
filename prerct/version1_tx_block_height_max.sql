SELECT MAX(block."height")
FROM monero block,
LATERAL unnest(block.transactions) tx
WHERE tx."version" = 1;