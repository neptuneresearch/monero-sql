CREATE VIEW coinbase_tx_attribute AS
    SELECT 
        block."height" AS block_height,
        (miner_tx)."version" AS tx_version,
        CARDINALITY((miner_tx).vout) AS tx_n_outputs,
        OCTET_LENGTH((miner_tx).extra) AS tx_len_extra
    FROM monero block
    ORDER BY block.height ASC;