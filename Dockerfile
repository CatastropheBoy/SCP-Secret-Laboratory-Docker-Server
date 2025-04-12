FROM cm2network/steamcmd:root
EXPOSE 7777/udp 7777/tcp

RUN apt update && apt install -y libicu-dev libicu72 && rm -rf /var/lib/apt/lists/* && apt-get clean

ENV GAMEID=996560 \
	GAMEDIR=/home/steam/SCP-Secret-Laboratory \
    SERVERPORT=7777 \
    SERVERNAME="SCP: Secret Laboratory" \
    MINPLAYERS=2

ENV CONFIGDIR=/home/steam/.configs/"SCP Secret Laboratory"/${SERVERPORT}

WORKDIR /home/steam

COPY --chown=steam docker_entry.sh ./

RUN chown -R steam:steam /home/steam 
RUN chmod a+rx docker_entry.sh

USER steam
CMD ["./docker_entry.sh"]