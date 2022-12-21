#!/bin/bash
set -euo pipefail
set -x

if ! which jq > /dev/null; then
  echo 'command jq not found, please install jq'
  exit 1
fi

if [[ -z "${CHAIN_ID:-}" ]]; then
  echo 'CHAIN_ID required'
  exit 1
fi

if [[ -z "${MNEMONIC:-}" ]]; then
  echo 'MNEMONIC required'
  exit 1
fi

jq-i() {
  edit="$1"
  f="$2"
  jq "$edit" "$f" > "${f}.tmp"
  mv "${f}.tmp" "$f"
}

palomad init VolumeFi --chain-id "$CHAIN_ID"

pushd ~/.paloma/config/
sed -i 's/^keyring-backend = ".*"/keyring-backend = "test"/' client.toml
sed -i 's/^minimum-gas-prices = ".*"/minimum-gas-prices = "0.001ugrain"/' app.toml
sed -i 's/^laddr = ".*:26657"/laddr = "tcp:\/\/0.0.0.0:26657"/' config.toml
jq-i ".chain_id = \"${CHAIN_ID}\"" genesis.json
popd

GR=000000ugrain
KGR="000${GR}"
MGR="000000${GR}"

FOUNDATION_AMOUNT="531250${KGR}"

VOLUME_AMOUNT="369${MGR}"
VOLUME_VALIDATOR_AMOUNT="6${MGR}"
INIT_VALIDATION_AMOUNT="5${MGR}"

COMMUNITY_VALIDATOR_AMOUNT="10${GR}"

name="Volume"
echo "$MNEMONIC" | palomad keys add "$name" --recover
address="$(palomad keys show "$name" -a)"

palomad add-genesis-account "$address" "$VOLUME_VALIDATOR_AMOUNT"
palomad gentx "$name" "$INIT_VALIDATION_AMOUNT" --chain-id "$CHAIN_ID"

init() {
  name="$1"
  address="$2"
  amount="${3:-"$COMMUNITY_VALIDATOR_AMOUNT"}"

  palomad add-genesis-account "$address" "$amount"
}

init PalomaFoundation1 paloma1786ghykqfeqtfstln97njuq39jcvmuzme94gcj "$FOUNDATION_AMOUNT"

init Volume1 paloma1wm4y8yhppxud6j5wvwr7fyynhh09tmv5x5sfzm "$VOLUME_AMOUNT"

init "Mason Borda" paloma10arp2v64rz4f6wx8ftlj2ktk3hzv359v3czf60 "5${MGR}"
init "MacLane Wilkison" paloma19gxy25w03v605cjwy5a0x92lw0p8nrs8qtke2w "5${MGR}"
init "Cassandra Shi" paloma1djpngum97kde3zyuactzf8rg2xls00t9q74qaw "5${MGR}"
init "Anatoly Yakovenko" paloma12ewmpgtm0ujufvsvd5wxaz5tehyxpt38fdgdm9 "3333333${GR}"
init "TRGC Ventures" paloma12nt749yerj89h0ql7l3durx8wspwtsg6caqk6y "26666667${GR}"

init StakingCabin paloma1qz30lp48lkdhcx2uw34v3mulc6se3wmw9yr5he
init Everstake paloma1sysfu6jw5q7za5t5ddhkjm7uvanvy6nm5ac5j8
init Helder paloma1h4u3haaqd8z3gqp2lrx9hhd799cpguj5ufegj2
init Baez paloma1rv786ey6j863szlkpwlrv784q6vgjm847hnvdz
init Alex@Confio paloma1ggdxy40e239gwv5uzdxlhgseyyaf52fnpcalys
init NodeJumper paloma1kludne80z0tcq9t7j9fqa630fechsjhxhpafac
init "PPNV Service" paloma16jhsvx4zrukkjqd9akfawx2tzduyx4uxgtjj42
init MCB paloma1d3v3jh6l2r23y9kgzdrahx0ev8ez0g8qapsfxs
init Nodes.Guru paloma15gvyk43x406v7kcd4rff5qfutqmcnpj3p4ea9g
init paloma.acloud.pp.ua paloma1swa5kcf9cl5dx2ypx0c5r9e5qdfnzp9wq59z2l
init SECARD paloma16lez38lgsgu34ka2gq8yee8a862zpgs4rt52xs
init kjnodes paloma13uslh0y22ffnndyr3x30wqd8a6peqh255hkzrz
init ecamli paloma1qf7np0rp3qutvn08vc6qz0y7ffc02cncpam3a7
init "ERN VENTURES" paloma1am3k7czusdcewv55nhaugu2drn38af9449yxzj
init "DiElektra | MMS" paloma1tdw23fpnxh2uk3djtteh7eaydymrfgnak3paq3
init mahof paloma1tsu8nthuspe4zlkejtj3v27rtq8qz7q62hx7ae
init catone paloma10y227j9d09pckexy32v2gckerj9a0kcepc7zsh
init mssahin paloma1z9fgzh7mzqgu33pdkxw0dqmqgm9l8exj4nggcp
init salomonval paloma1ljg6ed0pzc3xpqtareyfp6h4fpngs7nw0nnu2j
init VitaValeriya paloma19svt6tkvnu9wcjfwz2daglnxtm0frcavpzeyk2
init hdmiimdh paloma1hj4lxqp05ntjl6ezu3qn9eyedp5p4fpdwu8gxj
init ibrahimarslan paloma1xmm7rf06d3d8l5zmj2jmcjrfftf5kctn9602gt
init Conqueror paloma174l5um5rahquqxlvchyhfeveuue7j8faw7atq7
init NakoTurk paloma1sz3zjcyq8cd3e2k9kx6d44s8wnavfsy2gpf0y2
init beething paloma1p4r04ek0jnngegmw76rpx66xu9ep0kuzrge6jh
init Validator.run paloma1nlwzcegm7kxg6rpmkqmpl3afvapkyp4ml0f5cm
init 41uve12 paloma1c8uxkkz00qn97wsp9um8y3a8wlmrv3c5629jrn
init BDN paloma19dd8gaemmrn6q7clvn5xkskccdfwedk5j98zca
init Coinstamp paloma1jr353upa2jcg2af20lkq5ch60npk4a3wmcut9q
init wingsnodeteam paloma1j2zvqhxqycxlxj3stnmun8060wfhfw57up40dc
init Firstcome paloma1d0py2ucz2jrz69ca5l3pd4dfrmv64r24wu00ja
init BlockProducer paloma1u5xmuzrket78a6lw2shm06sluxcfhsrr08j6h0
init BlockStake paloma13jql7e3yx4n8xjj26mnt9jzytajpjyw6ggsh5k
init Illuminati paloma1q90vccjd2ewhngpkjc9rudwyz0pt9fxhej3ust
init POTM paloma12gxarx0lk2atvpwsvgsxkucglhu6gh4675c2tr
init Elite.Stake paloma1x3sngn5exusll2fhly6vh7el7v2t4lfxw06lv6
init Kinglsman paloma1h2adfqwras5q8p3hfgslfevj2ml7zs9srclv3s
init BVS.Network paloma17jzj4m5d6uaqh5s7slf9xhmwy4mkwxm9n0ymff
init Midora paloma1zhhwr8gk8pqf9p9eamxnqqstmtszjazwywr285
init nodepro.xyz aka gloreix paloma1xaelfvaltqr3g7lurvrxtuh4krhmtgw4jxw94z
init azstake paloma17kdfltcu45llx54ue0fvj8m4z9gd3ps4eg7v2n
init Alliance paloma1urx2ut6s33ngd8d4q7s969pe7w27ca0xgrtcf5
init Weakhand paloma1npxs5nr96twkn8fp00pq63dv52c2mqn6e6s6le
init MTnode paloma1848ywe2gnd23faedwzhzmxqgspp269fww39h77
init wabut.club paloma18tz9pqy2aaadax29xnszyvp805cf0fdpxtmz4h
init byte_master paloma1kqufqd069ewrst92augwrywaagkwyrjs0jkkez
init silent paloma1npwku4dmlnfwx9vqjnxzpfvdyxtcqvh3cqcl5x
init vVv paloma1elhz6uuxgjjfqd78pgcaz65mxyuvyxhevf8ryt
init moneyboss paloma13cfxrvldlpxdhn8mq9ydm3syyshddruzn45mvh
init KingSuper paloma1cs6trg6chgcw0t8dzjx9tup7emctxxtwehg6kq
init nazar-father paloma1s2jzpdfedxqfmttl55f9yvhmpgj738t2qkuaql
init AlxVoy paloma1my3gpyx7sdx7wn4rd0hmng60q9jhykxhfp7jqy

palomad collect-gentxs
