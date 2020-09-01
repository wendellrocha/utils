FROM ubuntu:18.04

# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget sudo

# Set up new user
RUN useradd -ms /bin/bash developer
RUN adduser developer sudo
RUN passwd -d developer
USER developer
WORKDIR /home/developer

# Install zsh
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/deluan/zsh-in-docker/master/zsh-in-docker.sh)" -- \
    -p git \
    -p ssh-agent \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions \
    -p https://github.com/zsh-users/zsh-history-substring-search \
    -p https://github.com/zsh-users/zsh-syntax-highlighting

RUN PATH="$PATH:/usr/bin/zsh"
# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"

# Download Dart SDK
RUN wget https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.4/sdk/dartsdk-linux-x64-release.zip
RUN unzip dartsdk-linux-x64-release.zip && rm dartsdk-linux-x64-release.zip
ENV PATH "$PATH:/home/developer/dart-sdk/bin"
ENV PATH "$PATH:/home/developer/.pub-cache/bin"

# Run basic check to download Dark SDK
RUN flutter channel beta
RUN flutter upgrade
RUN flutter doctor

# Set zsh default shell
ENTRYPOINT [ "/usr/bin/zsh" ]
CMD ["-l"]
