# Script to create genesis file

## Running the script
The setup script needs to be run from the validator machine that starts the chain. 

Steps to run the script (see example below)
1. Stop paloma and pigeon if running
2. Get the correct binary 
3. Copy script over to machine
4. Define the chain id variable `CHAIN_ID`
5. Define the mnenonic variable of the validator `MNEMONIC`
6. run the script

```
export CHAIN_ID=cumulet
export MNEMONIC="<YOUR MNEMONIC>"
export ADDRESS="<YOUR PALOMA ADDRESS>"
./setup-cumulet-mainnet.sh
```
    
## Important Notes
1. Since we want to edit some parameters in the genesis file, the network should not be started until the genesis file has been reviewed and updated after this script is run.
2. The script assumes that the Volume validator is starting the chain. If that is not the case, change the name in line 50.

