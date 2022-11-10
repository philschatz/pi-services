# Install

After gaining ssh access to the raspberry pi device, run the following lines:

```bash
# https://jfrog.com/connect/post/install-docker-compose-on-raspberry-pi/

sudo apt-get update
sudo apt-get upgrade --no-install-recommends -y
sudo apt-get install --no-install-recommends -y \
    git \
    pmount \
    downtimed \
    unattended-upgrades \
    avahi-daemon \
;

# https://forums.docker.com/t/failing-to-start-dockerd-failed-to-create-nat-chain-docker/78269
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
sudo reboot

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo usermod -aG docker ${USER}
sudo usermod -aG docker ${USER}
sudo su - ${USER}
docker version


wget https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-linux-$(uname -m) -O docker-compose
chmod +x docker-compose
sudo mv docker-compose /usr/local/bin/
docker-compose version
```

# Tips

If the Desktop Nextcloud client will not upload images because of 413 error, delete the `.sync_*.db` files in the client sync directory: https://github.com/nextcloud/docker/issues/762#issuecomment-633149958