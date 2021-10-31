CREATE VIEW monero_count_ringct_txo AS
    WITH miner_txs AS (
        SELECT 1
        FROM monero block
        WHERE (miner_tx).version = 2
    ),
    tx_outputs AS (
        SELECT 1
        FROM monero block,
        LATERAL UNNEST(block.transactions) tx,
        LATERAL UNNEST(tx.vout) vout
        WHERE vout.amount = 0
    ),
    combine_miner_txs_with_tx_outputs AS (
        SELECT
            *
        FROM miner_txs

        UNION ALL

        SELECT
            *
        FROM tx_outputs
    )
    SELECT 
        COUNT(*)
    FROM combine_miner_txs_with_tx_outputs;