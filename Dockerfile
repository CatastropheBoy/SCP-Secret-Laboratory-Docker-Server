FROM cm2network/steamcmd:root
EXPOSE 7777/udp 7777/tcp


ENV GAMEID=700330 \
	GAMEDIR=/home/steam/SCP-Secret-Laboratory

WORKDIR /home/steam

COPY --chown=steam docker_entry.sh ./

RUN chown -R steam:steam /home/steam 
RUN chmod a+rx docker_entry.sh

USER steam
CMD ["./docker_entry.sh"]