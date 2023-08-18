FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/usr/lib/jvm/java-11-oracle \
    JAVA_VERSION=11.0.19

RUN \
    apt-get update && apt-get dist-upgrade -y && \
    apt-get install apt-utils ca-certificates wget curl -y --no-install-recommends && \
    wget -qO java.tar.gz https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java11/java11019/jdk-"${JAVA_VERSION}"_linux-x64_bin.tar.gz && \
    tar xzf java.tar.gz -C /tmp && \
    mkdir -p /usr/lib/jvm && mv /tmp/jdk-"${JAVA_VERSION}" "${JAVA_HOME}" && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 1 && \
    update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" 1 && \
    update-alternatives --set java "${JAVA_HOME}/bin/java" && \
    update-alternatives --set javac "${JAVA_HOME}/bin/javac"
