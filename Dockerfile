FROM mcr.microsoft.com/vscode/devcontainers/typescript-node:0-10

ENV DEBIAN_FRONTEND=noninteractive
ARG ANDROID_HOME="/opt/android-sdk"
ARG ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ARG GRADLE_VERSION=5.6.2

#ARG JAVA_HOME="/usr/lib/jvm/java-8-oracle"

# Allgemein
RUN apt update \
    && apt install -y curl unzip software-properties-common gnupg2 zip openjdk-8-jdk-headless gradle --no-install-recommends

# Java
#RUN \
#  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
#  add-apt-repository -y ppa:webupd8team/java && \
#  apt-get update && \
#  apt-get install -y oracle-java8-installer --allow-unauthenticated && \
#  rm -rf /var/lib/apt/lists/* && \
#  rm -rf /var/cache/oracle-jdk8-installer
#ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle"
ENV PATH="$PATH:${JAVA_HOME}/bin"

# ANDROID STUFF
ENV PATH="$PATH:${ANDROID_HOME}/"
ENV PATH="$PATH:${ANDROID_HOME}/tools"
ENV PATH="$PATH:${ANDROID_HOME}/tools/bin"
ENV PATH="$PATH:${ANDROID_HOME}/build-tools"
ENV PATH="$PATH:${ANDROID_HOME}/platforms"
ENV PATH="$PATH:${ANDROID_HOME}/platform-tools"
ENV ANDROID_HOME="${ANDROID_HOME}"
ENV ANDROID_SDK_URL="${ANDROID_SDK_URL}"

RUN npm install -g --unsafe-perm \
    cordova@8.1.1 \
    @angular/cli@latest \
    @ionic/cli \
    @ionic/app-scripts \
    native-run

RUN mkdir ${ANDROID_HOME}/ -p \
    && wget -q ${ANDROID_SDK_URL} -O ${ANDROID_HOME}/files.zip \
    && unzip ${ANDROID_HOME}/files.zip -d $ANDROID_HOME/ \
    && rm ${ANDROID_HOME}/files.zip

RUN mkdir ~/.android/avd -p \
    && echo $ANDROID_HOME \
    && yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" "platforms;android-29" "platforms;android-28" "platforms;android-27" "build-tools;29.0.0" "build-tools;28.0.0" "build-tools;27.0.0" \
    && chmod 777 /opt/android-sdk

# Cleanup
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
    
ENV DEBIAN_FRONTEND=dialog

