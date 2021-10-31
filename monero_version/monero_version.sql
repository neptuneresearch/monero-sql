CREATE TABLE monero_version (
    height INTEGER,
    date VARCHAR,
    version INTEGER,
    software_version VARCHAR,
    software_version_recommended VARCHAR,
    details VARCHAR
);

INSERT INTO monero_version VALUES 
    (0,         '',             1,  'v0.0',         'v0.0',         'v1'),
    (1009827, 	'2016-03-22',   2, 	'v0.9.4', 	    'v0.9.4', 	    'Allow only >= ringsize 3, blocktime = 120 seconds, fee-free blocksize 60 kb'),
    (1141317, 	'2016-09-21',   3, 	'v0.9.4', 	    'v0.10.0', 	    'Splits coinbase into denominations'),
    (1220516,   '2017-01-05',   4, 	'v0.10.1', 	    'v0.10.2.1',    'Allow normal and RingCT transactions'),
    (1288616, 	'2017-04-15',   5, 	'v0.10.3.0', 	'v0.10.3.1', 	'Adjusted minimum blocksize and fee algorithm'),
    (1400000, 	'2017-09-16',   6, 	'v0.11.0.0', 	'v0.11.0.0', 	'Allow only RingCT transactions, allow only >= ringsize 5'),
    (1546000, 	'2018-04-06',   7, 	'v0.12.0.0', 	'v0.12.3.0', 	'Cryptonight variant 1, ringsize >= 7, sorted inputs'),
    (1685555, 	'2018-10-18',   8, 	'v0.13.0.0', 	'v0.13.0.4', 	'max transaction size at half the penalty free block size, bulletproofs enabled, cryptonight variant 2, fixed ringsize 11'),
    (1686275, 	'2018-10-19',   9, 	'v0.13.0.0', 	'v0.13.0.4', 	'bulletproofs required'),
    (1788000, 	'2019-03-09',   10, 'v0.14.0.0', 	'v0.14.1.2', 	'New PoW based on Cryptonight-R, new block weight algorithm, slightly more efficient RingCT format'),
    (1788720, 	'2019-03-10',   11, 'v0.14.0.0', 	'v0.14.1.2', 	'forbid old RingCT transaction format'),
    (1978433, 	'2019-11-30*',  12, 'v0.15.0.0', 	'v0.16.0.0',    'New PoW based on RandomX, only allow >= 2 outputs, change to the block median used to calculate penalty, v1 coinbases are forbidden, rct sigs in coinbase forbidden, 10 block lock time for incoming outputs'),
    (2210000,   '2020-10-17',   13, 'v0.17.0.0',    'v0.17.1.1',    'New CLSAG transaction format'),
    (2210720,   '2020-10-18',   14, 'v0.17.1.1', 	'v0.17.1.7',    'forbid old')
;

-- UPDATE THIS VALUE - Current version row: use the max height of the application you're JOINing with monero_version.
INSERT INTO monero_version VALUES 
    (2457499, 'tx_ringmember_list_block_height_max', 15, 'CURRENT', 'CURRENT', 'End of database per tx_ringmember_list_block_height_max');