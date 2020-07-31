FROM debian:testing

LABEL BUILD="docker build -t insomniacslk/bjn -f Dockerfile ."
LABEL RUN="docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -h $HOSTNAME -v $HOME/.Xauthority:/home/bjn/.Xauthority insomniacslk/bjn"

RUN apt-get update &&                          \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        libnss3 \
        gconf2 \
        libnotify4 \
        libappindicator1 \
        libxtst6 \
        libxss1 \
        libgtk-3-0 \
        libx11-xcb1 \
        libasound2 \
    && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 bjn
RUN useradd -d /home/bjn -s /bin/bash -m bjn -u 1000 -g 1000
WORKDIR /home/bjn
RUN wget https://swdl.bluejeans.com/desktop-app/linux/2.5.0/BlueJeans_2.5.0.50.deb
RUN dpkg -i BlueJeans_2.5.0.50.deb
RUN ln -s /opt/BlueJeans/bluejeans-v2 /usr/local/bin/bjn
USER bjn

CMD ["/opt/BlueJeans/bluejeans-v2"]
