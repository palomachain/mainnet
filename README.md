# Paloma mainnet for Messenger
## Genesis Files

This is the Paloma mainnet genesis document released on February 1, 2023 to begin the collection of gentxes from the Paloma Community Validators and Professional validators that make up the flock. 

1. If you are submitting a gentx, only those Paloma testnet addresses that are in the configuration file will be merged. Check for your address in list of delegator addresses here: https://github.com/palomachain/mainnet/blob/master/messenger/scripts/setup-cumulet-mainnet.sh#L82-L134. If your address is not in this list, the pull request will be closed.

2. All addresses that are approved addresses were confirmed by governance vote on Paloma here: https://forum.palomachain.com/t/pip-11-validator-airdrop-on-paloma-mainnet/156. Please do not ask us to add your address after the fact. 

3. If you are submitting a gentx, please do not use up all your GRAINs for your validator. More than 1 GRAIN, but less than 10 GRAINs so that you have enough grains for gas to redelegate staking rewards.

## Paloma Messenger Mainnet Genesis Instructions

To add your validator information to the genesis file for the "messenger" mainnet

1. Add this repo's genesis file to the machine that has your keys listed in this repo's genesis file
2. Run the `palomad gentx [key_name] [amount] [flags]` command     
    i. see `palomad gentx --help` for more details    
    ii. ensure that you use flag `--chain-id messenger`.    
3. Fork this repo 
4. Copy the generated gentx json file into <REPO-PATH>/messenger/gentxs/
5. Commit, push and open a PR


If you need to change the paloma address listed in this genesis file, open a support ticket Discord.

Let's go Flock!
COO! 
Paloma
