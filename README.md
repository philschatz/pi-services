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

## Make useful preview sizes:

```sh
docker exec -u 33 -it pi-services-app-1 /bin/bash

# Then run these in the terminal:
# Source: https://web.archive.org/web/20220531110907/https://ownyourbits.com/2019/06/29/understanding-and-improving-nextcloud-previews/
/var/www/html/occ config:app:set previewgenerator squareSizes --value="32 64 256 512"
/var/www/html/occ config:app:set previewgenerator widthSizes  --value="256 384"
/var/www/html/occ config:app:set previewgenerator heightSizes --value="256"


/var/www/html/occ config:system:set preview_max_x --value 1024
/var/www/html/occ config:system:set preview_max_y --value 1024
/var/www/html/occ config:system:set jpeg_quality --value 60
/var/www/html/occ config:app:set preview jpeg_quality --value="60"

# Generate all the previews
time /var/www/html/occ preview:generate-all
```

## Set a cron job to generate previews:

[link](https://github.com/nextcloud/docker/issues/1775#issuecomment-1272609711)

Or mount the spool file: https://davidhettler.net/blog/the-problematic-nextcloud-gallery/


## Disable previews

https://docs.nextcloud.com/server/latest/admin_manual/configuration_files/previews_configuration.html#disabling-previews


## Photoprism

Increase swap size to 2048 (that's enough for Photoprism) https://pimylifeup.com/raspberry-pi-swap-file/

# Tips

If the Desktop Nextcloud client will not upload images because of "413 Request Entity Too Large" error, delete the `.sync_*.db` files in the client sync directory: https://github.com/nextcloud/docker/issues/762#issuecomment-633149958

## Logging

```sh
cd pi-services && docker-compose logs -f

journalctl --follow

htop
```