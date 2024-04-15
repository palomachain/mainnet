1. `sudo service palomad stop`
2. `sudo service pigeond stop`
3. update the chain id id in the `~/.pigeon/config.yaml` file to `racer` 
4. Optional if using: update chain id in `~/.paloma/config/client.toml` to `racer`
5. Add persistent peers: 
    1. update `~/.paloma/config/config.toml`
        1. Line 215: add  
        ```
        persistent_peers = "ab6875bd52d6493f39612eb5dff57ced1e3a5ad6@95.217.229.18:10656, a9a0a77dfd05b42b14461c57e8a1f252c7deeef3@198.244.228.162:54056, 16f0d09580054101394ea08bbb48b1ad5bb91a27@95.214.52.144:10656, eea0d51296fe41693c90cc0b263635b0945e2231@91.228.224.197:26656, 2c6772b11c1f9eff2a923eb2bf808543cdd501c5@79.143.179.196:26656, aebcb6dd3664d472014c03cbd7c15ef604703644@173.234.17.194:26656, ccf22275efe0a3cefd52d636aac3c4774b23a5ac@65.108.197.164:56105"
        ```
6. Get new genesis
    1. `wget -O ~/.paloma/config/genesis.json https://raw.githubusercontent.com/palomachain/mainnet/master/racer/genesis.json`
7. **`palomad comet unsafe-reset-all --home $HOME/.paloma`**
8. `echo '{}' > ~/.paloma/config/addrbook.json`
9. `sudo service pigeond start`
10. `sudo service palomad start`
