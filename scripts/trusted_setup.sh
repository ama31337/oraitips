#!/bin/bash

# install docker and compose
#sudo apt insatll -y jq
#curl -fsSL https://get.docker.com -o get-docker.sh
#sudo sh get-docker.sh
#sudo service docker restart
#sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose

# Download and run the trusted setup file
cd $HOME/
curl -OL https://raw.githubusercontent.com/oraichain/oraichain-static-files/master/mainnet-static-files/setup.sh && chmod +x ./setup.sh && ./setup.sh

# edit orai.env
sed -i 's/USER=test1/USER=lux8.net/g' $HOME/orai.env
sed -i 's/MONIKER=test1_moniker/MONIKER=lux8.net/g' $HOME/orai.env
sed -i 's%WEBSITE=xyx.com%WEBSITE="https://lux8.het"%g' $HOME/orai.env
sed -i 's%DETAILS=helloworld%DETAILS="Fial Lux. Infinite Lux."%g' $HOME/orai.env

# build container
docker-compose pull && docker-compose up -d --force-recreate

# initiate node
docker-compose exec orai bash -c 'wget -O /usr/bin/fn https://raw.githubusercontent.com/oraichain/oraichain-static-files/master/fn.sh && chmod +x /usr/bin/fn' && docker-compose exec orai fn init
# backup node keys
NUM=`date +%F`
NUM=${NUM}-$RANDOM
mkdir -p $HOME/trusted-bak-${NUM}
sudo cp {.oraid/config/node_key.json,.oraid/config/priv_validator_key.json} ~/trusted-bak-${NUM}

# download genesis and start node
cd ~/.oraid/data && find . -not -name '*.json' -delete
curl -L https://raw.githubusercontent.com/ama31337/oraitips/main/scripts/genesis.json > $HOME/genesis.json
sudo cp $HOME/genesis.json $HOME/.oraid/config/genesis.json
# sed -i 's/persistent_peers = ""/persistent_peers = "d549bdd442caadf557672f9b4efefdff80ee28e2@178.128.57.195:26656"/g' ~/.oraid/config/config.toml
docker-compose restart orai && docker-compose exec -d orai bash -c 'oraivisor start --p2p.pex false --p2p.persistent_peers "d64eedd36edb1751dfcf9310183ca4bd85bdafbd@13.58.238.192"'

echo "done"

