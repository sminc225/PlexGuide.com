#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
#################################################################################

# KEY VARIABLE RECALL & EXECUTION
mkdir -p /pg/var/cron/
mkdir -p /pg/var/cron
# FUNCTIONS START ##############################################################
source /pg/pgblitz/menu/functions/functions.sh

weekrandom () {
  while read p; do
  echo "$p" > /pg/tmp/program_var
  echo $(($RANDOM % 23)) > /pg/var/cron/cron.hour
  echo $(($RANDOM % 59)) > /pg/var/cron/cron.minute
  echo $(($RANDOM % 6))> /pg/var/cron/cron.day
  ansible-playbook /pg/pgblitz/menu/cron/cron.yml
  done </pg/var/pgbox.buildup
  exit
}

dailyrandom () {
  while read p; do
  echo "$p" > /pg/tmp/program_var
  echo $(($RANDOM % 23)) > /pg/var/cron/cron.hour
  echo $(($RANDOM % 59)) > /pg/var/cron/cron.minute
  echo "*/1" > /pg/var/cron/cron.day
  ansible-playbook /pg/pgblitz/menu/cron/cron.yml
  done </pg/var/pgbox.buildup
  exit
}

manualuser () {
  while read p; do
  echo "$p" > /pg/tmp/program_var
  bash /pg/pgblitz/menu/cron/cron.sh
  done </pg/var/pgbox.buildup
  exit
}


# FIRST QUESTION
question1 () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛ PG Cron - Schedule Cron Jobs (Backups) | Mass Program Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ Reference: http://cron.pgblitz.com

1 - No  [Skip   - All Cron Jobs]
2 - Yes [Manual - Select for Each App]
3 - Yes [Daily  - Select Random Times]
4 - Yes [Weekly - Select Random Times & Days]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed < /dev/tty
  if [ "$typed" == "1" ]; then exit;
elif [ "$typed" == "2" ]; then manualuser && ansible-playbook /pg/pgblitz/menu/cron/cron.yml;
elif [ "$typed" == "3" ]; then dailyrandom && ansible-playbook /pg/pgblitz/menu/cron/cron.yml;
elif [ "$typed" == "4" ]; then weekrandom && ansible-playbook /pg/pgblitz/menu/cron/cron.yml;
else badinput1; fi
}

question1
