# Paloma Cumulet Mainnet Genesis 

To add your validator information to the genesis file

1. Add this repo's genesis file to the machine that has your keys listed in this repo's genesis file
2. Run the `palomad gentx [key_name] [amount] [flags]` command 
    i. see `palomad gentx --help` for more details
    ii. ensure that you use flag `--chain-id cumulet`.
3. Fork this repo and make a PR on this repo with your output of the `palomad gentx` command.


If you need to change the paloma address listed in this genesis file, open a support ticket Discord.