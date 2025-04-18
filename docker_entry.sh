#!/bin/sh

${STEAMCMDDIR}/steamcmd.sh +force_install_dir ${GAMEDIR} +login anonymous \
+app_update ${GAMEID} validate +quit

cd "${GAMEDIR}"

# Ensure config directory exists
mkdir -p "${CONFIGDIR}"

# Edit the config file
set_config_value() {
local file="$1"
local key="$2"
local value="$3"

if grep -q "^${key}:" "$file" 2>/dev/null; then
sed -i "s|^${key}:.*|${key}: ${value}|" "$file"
else
echo "${key}: ${value}" >> "$file"
fi
}

echo "Editing config file \"${CONFIGDIR}/config_gameplay.txt\""

set_config_value "${CONFIGDIR}/config_gameplay.txt" "server_name" "Tako and Teneb's spooky experiment place"
set_config_value "${CONFIGDIR}/config_gameplay.txt" "minimum_players" "${MINPLAYERS}"
set_config_value "${CONFIGDIR}/config_gameplay.txt" "max_players" "64"
set_config_value "${CONFIGDIR}/config_gameplay.txt" "player_list_title" "Soon to be dead peeps"
set_config_value "${CONFIGDIR}/config_gameplay.txt" "serverinfo_pastebin_id" "7wV681fT"

cat "${CONFIGDIR}/config_gameplay.txt"


replace_config_value() { 
local file="$1" 
local key="$2"
local value="$3"

local escaped_key=$(sed 's/[^^]/[&]/g; s/\^/\\^/g' <<< "$key")

if grep -q -P "^${escaped_key}\b" "$file" 2>/dev/null; then
sed -i -E "s|^${escaped_key}\b.*|${value}|" "$file"
else
echo "${value}" >> "$file"
fi
}


replace_config_value "${CONFIGDIR}/config_remoteadmin.txt" " - SomeSteamId64@steam: owner" " - 76561198002522771@steam: owner" 
replace_config_value "${CONFIGDIR}/config_remoteadmin.txt" " - SomeOtherSteamId64@steam: admin" " - 76561198062794058@steam: admin"


cat "${CONFIGDIR}/config_remoteadmin.txt"

exec ./LocalAdmin ${SERVERPORT} --acceptEULA --useDefault
