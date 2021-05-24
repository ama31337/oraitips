# Tutorial to run Oraid validator as a service and proceed manual update

### Installation
 1. First you nede to get oraid binary and put it in ~/.local/bin inside your home folder
```sh
mkdir -p $HOME/.local/bin
curl -s <ORAID_URL> > $HOME/.local/bin/oraid
chmod +x $HOME/.local/bin/oraid
```
 2. Create systemd file to run oraid as a service, we prepare a script to setup it in one command.
Clone repo and run installation script
```sh
cd $HOME; git clone https://github.com/ama31337/oraitips.git
cd $HOME/oraitips/scripts; ./setup_systemd.sh
```
Script will create oraid service and aliases to easily manage node start, stop, and chech logs.
To make aliases work, run:
```sh
source ~/.bashrc
```
And now you can start your node and check logs
```
oraistart
orailogs
```
ctrl+c for exit (node will continue work in background).

 3. If you run a node via systemd, you need to check for new versions and update in manually. When you see in logs something like
`
UPGRADE "v0.3.1" NEEDED at height: 102952: http://128.199.70.52:8080/ipfs/QmSgXgV9in6uGyLMdvtPNQqTLgqGJMgJX5inTDAYyQk1UQ
`
you need to update oraid binary
 4. Get oriad link
```sh
curl -s http://128.199.70.52:8080/ipfs/QmSgXgV9in6uGyLMdvtPNQqTLgqGJMgJX5inTDAYyQk1UQ | jq
```
 5. Make a backup of your previous binary to be able to run it in case of update failure.

```sh
cp $HOME/.local/bin/oraid $HOME/.local/bin/oraid-bak
```
 6. Download new binary and restart your oraid service
```sh
curl <BINARY_URL> > $HOME/.local/bin/oraid
chmod +x $HOME/.local/bin/oraid
oraistop; oraistart
```
 7. Check new version
```sh
oraid version
```

 Done! You've succesfully update your oraid binary.
