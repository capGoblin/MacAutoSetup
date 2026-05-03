#!/bin/bash

# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>true</swiftbar.hideSwiftBar>

AEROSPACE=/opt/homebrew/bin/aerospace
FOCUSED=$("$AEROSPACE" list-workspaces --focused 2>/dev/null | tr -d '[:space:]')

# Always show all 10 workspaces
WORKSPACES=($("$AEROSPACE" list-workspaces --all 2>/dev/null))

TITLE=""
for ws in "${WORKSPACES[@]}"; do
  if [ "$ws" = "$FOCUSED" ]; then
    # Active: Bold White
    TITLE+=$'\033[1;37m'"$ws"$'\033[0m'
  else
    # Inactive: Medium Gray (More Mac-like than dark gray)
    TITLE+=$'\033[38;5;246m'"$ws"$'\033[0m'
  fi
  TITLE+="   " # Breathing room
done

# Strip trailing spaces
TITLE="${TITLE%   }"

# Using 'SF Pro Rounded' and a slightly larger size for a premium feel
printf "%s | ansi=true size=13 font='SF Pro Rounded'\n" "$TITLE"
echo "---"

for ws in "${WORKSPACES[@]}"; do
  if [ "$ws" = "$FOCUSED" ]; then
    echo "$ws — current | bash='$AEROSPACE' param1='workspace' param2='$ws' terminal=false refresh=true size=13"
  else
    echo "$ws | bash='$AEROSPACE' param1='workspace' param2='$ws' terminal=false refresh=true size=13 color=#888888"
  fi
done
