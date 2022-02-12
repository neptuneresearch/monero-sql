-- This is a view based on an unindexed array column (monero.transactions), so JOINing it on anything
-- besides block height will be slow. For JOIN usage, materialize it up to a certain height,
-- and index tx_hash.
-- Runtime @H=2508299: 1m20s
CREATE MATERIALIZED VIEW tx_attribute AS (
    SELECT 
        block."height" AS block_height,
        block."timestamp" AS block_timestamp,
        tx.ordinality AS tx_index,
        tx.hash AS tx_hash,
        tx."version" AS tx_version,
        tx.unlock_time AS tx_unlock_time,
        CARDINALITY(tx.vin) AS tx_n_inputs,
        CARDINALITY(tx.vout) AS tx_n_outputs,
        OCTET_LENGTH(tx.extra) AS tx_len_extra,
        tx.fee AS tx_fee
    FROM monero block,
    LATERAL unnest(block.transactions) WITH ORDINALITY tx(hash, version, unlock_time, vin, vout, extra, fee)
    ORDER BY block.height ASC, tx.ordinality ASC
) WITH NO DATA;

-- Runtime @H=2508299: 16s
CREATE INDEX tx_attribute_tx_hash ON tx_attribute (tx_hash);