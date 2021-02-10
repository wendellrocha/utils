#!/bin/bash

sudo apt install -y gnupg apt-transport-https wget ca-certificates dirmngr software-properties-common

wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'

sudo apt update

sudo apt install -y curl git unzip xz-utils zip libglu1-mesa
sudo apt install -y nodejs build-essential adoptopenjdk-8-hotspot
sudo apt install -y mongodb-org-shell=4.4.2 mongodb-org-mongos=4.4.2 mongodb-org-tools=4.4.2 dart

sudo update-alternatives --config java

mkdir -p Android/sdk
mkdir -p .android && touch .android/repositories.cfg

wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
unzip sdk-tools.zip && rm sdk-tools.zip

mv tools ~/Android/sdk/tools
cd ~/Android/sdk/tools/bin && yes | ./sdkmanager --licenses
cd ~/Android/sdk/tools/bin && ./sdkmanager  "patcher;v4" "platform-tools" \
    "platforms;android-30" \
    "platforms;android-29" \
    "platforms;android-28" \
    "build-tools;30.0.2" \
    "build-tools;30.0.0" \
    "build-tools;29.0.3" \
    "build-tools;29.0.2" \
    "build-tools;29.0.1" \
    "build-tools;29.0.0" \
    "build-tools;28.0.3" \
    "build-tools;28.0.2" \
    "build-tools;28.0.1" \
    "build-tools;28.0.0" \
    "sources;android-30" \
    "sources;android-29" \
    "sources;android-28"

cd ~
curl https://install.meteor.com/ | sh

pub global activate fvm
pub global activate slidy

fvm use 1.23.0-18.1.pre --global
fvm install 1.26.0-17.3.pre