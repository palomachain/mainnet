1. `sudo service palomad stop`
2. `sudo service pigeond stop`
3. Download the latest paloma v1.13.1 from 04/16/2024 release date.
  ```shell
  wget -O - https://github.com/palomachain/paloma/releases/download/v1.13.1/paloma_Linux_x86_64.tar.gz  | \
  sudo tar -C /usr/local/bin -xvzf - palomad 
  sudo chmod +x /usr/local/bin/palomad
  ```
4. If you're building from source, you'll need to delete the directory and reclone
   ```shell
   rm -rf paloma
   git clone https://github.com/palomachain/paloma.git
   cd paloma
   git checkout v1.13.1
   make build
   sudo mv ./build/palomad /usr/local/bin/palomad
   ```
5. **Confirm that you have the correct binary**: 
   ```shell
    palomad version --long | grep commit
   ```
   **Expected output `1143f40382ff1540dc134ceecf11b50af756428a`**
6. confirm that you're on pigeon v1.11.0 or download it
  ```shell
  wget -O - https://github.com/palomachain/pigeon/releases/download/v1.11.0/pigeon_Linux_x86_64.tar.gz  | \
  sudo tar -C /usr/local/bin -xvzf - pigeon
  sudo chmod +x /usr/local/bin/pigeon
  ```
7. Update the chain id id in the `~/.pigeon/config.yaml` file to `racer` 
8. Optional if using: update chain id in `~/.paloma/config/client.toml` to `racer`
9. Add persistent peers: 
    1. update `~/.paloma/config/config.toml`
        1. Line 215: add  
        ```
        persistent_peers = "ab6875bd52d6493f39612eb5dff57ced1e3a5ad6@95.217.229.18:10656, a9a0a77dfd05b42b14461c57e8a1f252c7deeef3@198.244.228.162:54056, 16f0d09580054101394ea08bbb48b1ad5bb91a27@95.214.52.144:10656, eea0d51296fe41693c90cc0b263635b0945e2231@91.228.224.197:26656, 2c6772b11c1f9eff2a923eb2bf808543cdd501c5@79.143.179.196:26656, aebcb6dd3664d472014c03cbd7c15ef604703644@173.234.17.194:26656, ccf22275efe0a3cefd52d636aac3c4774b23a5ac@65.108.197.164:56105"
        ```
10. Get new genesis
     ```shell
     wget -O ~/.paloma/config/genesis.json https://raw.githubusercontent.com/palomachain/mainnet/master/racer/genesis.json
    ```
11. **IMPORTANT** 
     ```shell
     palomad comet unsafe-reset-all --home $HOME/.paloma`
    ```
12. `echo '{}' > ~/.paloma/config/addrbook.json`
13. To speed up prevote rounds and reduce the timeout delta, please update your `~/.paloma/config/config.toml`. from 500ms to 100ms. See below
   ```shell
   #How much the timeout_precommit increases with each round
   timeout_precommit_delta = "100ms"
   ```
14.   `sudo service pigeond start`
15.   `sudo service palomad start`
