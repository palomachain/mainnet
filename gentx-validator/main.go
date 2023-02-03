package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strings"

	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/x/auth/signing"
	genutiltypes "github.com/cosmos/cosmos-sdk/x/genutil/types"
	stakingtypes "github.com/cosmos/cosmos-sdk/x/staking/types"
	"github.com/palomachain/paloma/app"
)

var (
	minCommissionAllowed = sdk.MustNewDecFromStr("0.02")
)

func main() {
	for i, file := range os.Args {
		if i == 0 {
			continue
		}

		if !strings.Contains(file, ".json") {
			continue
		}

		if filepath.Dir(file) != "gentxs" {
			log.Fatal("gentxs should go into the gentx directory")
		}

		fileContents, err := ioutil.ReadFile(file)
		if err != nil {
			log.Fatal(err)
		}

		var genTx json.RawMessage
		if err := json.Unmarshal(fileContents, &genTx); err != nil {
			log.Fatal(err)
		}

		encCfg := app.MakeEncodingConfig()
		genState := genutiltypes.GenesisState{GenTxs: []json.RawMessage{genTx}}

		txJSONDecoder := encCfg.TxConfig.TxJSONDecoder()
		for i, genTx := range genState.GenTxs {
			var tx sdk.Tx

			tx, err := txJSONDecoder(genTx)
			if err != nil {
				log.Fatal(err)
			}

			msgs := tx.GetMsgs()
			if n := len(msgs); n != 1 {
				log.Fatal(fmt.Errorf("gentx %d contains invalid number of messages; expected: 1; got: %d", i, n))
			}

			if msgCreateVal, ok := msgs[0].(*stakingtypes.MsgCreateValidator); ok {
				err := msgCreateVal.ValidateBasic()
				if err != nil {
					log.Fatal(err)
				}

				if msgCreateVal.Value.Denom != app.BondDenom {
					log.Fatalf("Delegation denomination must be %s", app.BondDenom)
				}

				if msgCreateVal.Commission.Rate.LT(minCommissionAllowed) {
					log.Fatalf("Validator commission must be at least 2%%: %s", msgCreateVal.Commission.Rate)
				}
			} else {
				log.Fatal(fmt.Errorf(
					"gentx %d contains invalid message at index 0; expected: %T; got: %T",
					i, &stakingtypes.MsgCreateValidator{}, msgs[0],
				))
			}
		}

		// double check it's a well formed TX
		tx, err := encCfg.TxConfig.TxJSONDecoder()(fileContents)
		if err != nil {
			log.Fatal(err)
		}

		if err := tx.ValidateBasic(); err != nil {
			log.Fatal(err)
		}

		txBuilder, err := encCfg.TxConfig.WrapTxBuilder(tx)
		if err != nil {
			log.Fatal(err)
		}

		signatures, err := txBuilder.GetTx().GetSignaturesV2()
		if err != nil {
			log.Fatal(err)
		}

		// validate signatures
		for _, sig := range signatures {
			err := signing.VerifySignature(sig.PubKey, signing.SignerData{
				ChainID:       "cumulet",
				AccountNumber: 0,
				Sequence:      sig.Sequence,
			},
				sig.Data,
				encCfg.TxConfig.SignModeHandler(),
				tx,
			)
			if err != nil {
				log.Fatal(err)
			}
		}

		log.Println("gentx is valid!")
	}
}
