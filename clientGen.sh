wg genkey | tee privKeyClient
cat privKeyClient | wg pubkey | tee pubKeyClient
privKeyClient=$(cat privKeyClient)
pubKeyClient=$(cat pubKeyClient)
read -p "Please enter the public key of your server:" -e srvPubKey
read -p "Please enter the domain/IP and port of your server[e.g. example.com:21111]:" -e endpoint
read -p "Please enter the range of allowed ips[0.0.0.0/0]:" -i "0.0.0.0/0" -e allowedips
read -p "Please enter the internal address in the LAN [e.g. 192.0.0.1/24]" -e clientInternalIP
read -p "Please enter DNS[1.1.1.1]:" -i "1.1.1.1" -e DNS
read -p "Please enter MTU[1420]" -i "1420" -e MTU
read -p "Please enter the private key of your client["+$privKeyClient+"]:" -i $privKeyClient -e clientPrivKey
read -p "Name of your config?[client.conf]:" -i "client.conf" -e configName

echo "
[Interface]
PrivateKey = $clientPrivKey
Address = $clientInternalIP
DNS = $DNS
MTU = $MTU

[Peer]
PublicKey = $srvPubKey
AllowedIPs = $allowedips
Endpoint = $endpoint
PersistentKeepalive = 25
" > $configName

bash ./addPeer.sh
