# Paloma Messenger Mainnet Genesis 

To add your validator information to the genesis file for the "messenger" mainnet

1. Add this repo's genesis file to the machine that has your keys listed in this repo's genesis file
2. Run the `palomad gentx [key_name] [amount] [flags]` command     
    i. see `palomad gentx --help` for more details    
    ii. ensure that you use flag `--chain-id messenger`.    
3. Fork this repo 
4. Copy the generated gentx json file into <REPO-PATH>/messenger/gentxs/
5. Commit, push and open a PR


If you need to change the paloma address listed in this genesis file, open a support ticket Discord.