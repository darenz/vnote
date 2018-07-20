#!/bin/bash

sudo chmod +x ./vnote.sh
sudo cp ./vnote.sh /usr/bin  
sudo ln -s /usr/bin/vnote.sh /usr/bin/vnote
sudo ln -s /usr/bin/vnote.sh /usr/bin/nt

sudo echo "alias nt='vnote'" >> ~/.bashrc
echo "done"
