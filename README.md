# How to set up a telegram alerts for ORAI node

### Installation
 1. Clone repository to your server
```sh
cd $HOME && git clone -v https://github.com/ama31337/oraitips.git
```
 2. Edit is_jailed.sh script with your moniker (MONIKER='"YOUR_MONIKER"')
```sh
vim $HOME/oraitips/scripts/is_jailed.sh
```
 3. Create new telegram bot via @botfarter and change bot_api_token and tg_chat_or_user_id (chat with your bot or your user ID for direct messages from bot) inside Send_msg_toTelBot.sh
```sh
vim $HOME/oraitips/scripts/Send_msg_toTelBot.sh
```
 4. Make scripts execurable
```sh
chmod +x $HOME/oraitips/scripts/*.sh
```
 5. Create cronjob to execute scripts every 5 minute:

 check your $HOME path to the correct one
```sh
echo $HOME
```
 open crontab 
```sh
crontab -e
```
 and change $HOME to the output of prev. command
```sh
*/5 * * * *      cd $HOME/oraitips/scripts && ./check_sync.sh >> $HOME/oraitips/scripts/check_sync.log
*/5 * * * *      cd $HOME/oraitips/scripts && ./is_jailed.sh >> $HOME/oraitips/scripts/is_jailed.log
```
 Done! You've succesfully setup telegram alerts to check your node health.
