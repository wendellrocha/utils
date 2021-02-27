#!/bin/bash
sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf check-update
sudo dnf update -y

sudo dnf install java-1.8.0-openjdk.x86_64

sudo touch /etc/yum.repos.d/mongodb-org.4.4.repo

sudo sh -c 'echo -e "[mongodb-org-4.4]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/8Server/mongodb-org/4.4/x86_64/\ngpgcheck=1\nenabled=1\ngpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc" > /etc/yum.repos.d/mongodb-org.4.4.repo'

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

sudo update-alternatives --config java

sudo dnf check-update
sudo dnf install -y mongodb-org-shell mongodb-org-mongos mongodb-org-tools code fira-code-fonts elixir git zsh nodejs

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

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

wget -O dart-sdk.zip https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-x64-release.zip
unzip dart-sdk.zip && rm dart-sdk.zip
export PATH=$PATH:/home/wendellr/dart-sdk/bin
export PATH=$PATH:/home/wendellr/.pub-cache/bin

pub global activate fvm
pub global activate slidy

fvm use 1.23.0-18.1.pre --global
fvm install 1.26.0-17.3.pre

wget https://raw.githubusercontent.com/wendellrocha/utils/master/linux/.zshrc
