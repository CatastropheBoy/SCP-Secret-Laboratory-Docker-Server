#!/bin/sh

${STEAMCMDDIR}/steamcmd.sh +force_install_dir ${GAMEDIR} +login anonymous \
     +app_update ${GAMEID} validate +quit

exec ${GAMEDIR}/LocalAdmin ${SERVERPORT} --acceptEULA
