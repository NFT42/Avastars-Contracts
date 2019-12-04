const {spawn} = require('child_process');
const keys = require('./.project_keys');

const ganache = spawn('npx', ['ganache-cli', '-p 7545', '-d', `-m '${keys.mnemonic}`, '-l 9950000', '-e 1000']);

ganache.stdout.on('data', (data) => {
    let trimmed = String(data).trim();
    let regex = /eth_getFilterChanges|eth_getBlockByNumber|eth_blockNumber|net_version|eth_accounts|eth_getCode|eth_getTransactionReceipt|eth_estimateGas/gi;
    let filtered = trimmed.replace(regex, '').trim();
    regex = /eth_sendTransaction/gi;
    filtered = filtered.replace(regex, '\neth_sendTransaction');
    regex = /eth_call/gi;
    filtered = filtered.replace(regex, '\neth_call');
    if (filtered.length > 0) console.log(filtered);
});

ganache.stderr.on('data', (data) => {
    console.log(`ERROR: ${data}`);
});

ganache.on('close', (code) => {
    console.log(`child process exited with code ${code}`);
});