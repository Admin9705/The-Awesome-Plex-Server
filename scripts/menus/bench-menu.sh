#!/bin/bash

clear

function contextSwitch {
   {
   ctxt1=$(grep ctxt /proc/stat | awk '{print $2}')
       echo 50
   sleep 1
       ctxt2=$(grep ctxt /proc/stat | awk '{print $2}')
       ctxt=$(($ctxt2 - $ctxt1))
       result="Number os context switches in the last secound: $ctxt"
   echo $result > result
   } | whiptail --gauge "Getting data ..." 6 60 0
}


function userKernelMode {
   {
   raw=( $(grep "cpu " /proc/stat) )
       userfirst=$((${raw[1]} + ${raw[2]}))
       kernelfirst=${raw[3]}
   echo 50
       sleep 1
   raw=( $(grep "cpu " /proc/stat) )
       user=$(( $((${raw[1]} + ${raw[2]})) - $userfirst ))
   echo 90
       kernel=$(( ${raw[3]} - $kernelfirst ))
       sum=$(($kernel + $user))
       result="Percentage of last sekund in usermode: \
       $((( $user*100)/$sum ))% \
       \nand in kernelmode: $((($kernel*100)/$sum ))%"
   echo $result > result
   echo 100
   } | whiptail --gauge "Getting data ..." 6 60 0
}

function interupts {
   {
   ints=$(vmstat 1 2 | tail -1 | awk '{print $11}')
       result="Number of interupts in the last secound:  $ints"
   echo 100
   echo $result > result
   } | whiptail --gauge "Getting data ..." 6 60 50
}

while [ 1 ]
do
CHOICE=$(
whiptail --title "Benchmark Menu (The Creator)" --menu "Make Your Choice!" 12 44 5 \
   "1)" "System Info and Benchmark - Basic"  \
   "2)" "System Info and Benchmark - Advanced"  \
   "3)" "System Info and Benchmark - Custom"  \
   "4)" "Simple Speedtest"  \
   "5)" "Exit  "  3>&2 2>&1 1>&3
)

result=$(whoami)
case $CHOICE in

     "1)")
     echo "Do you want to run BASIC benchmark and information? (y/n)? "
     old_stty_cfg=$(stty -g)
     stty raw -echo
     answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
     stty $old_stty_cfg
     if echo "$answer" | grep -iq "^y" ;then
         echo Yes;

     sudo wget -qO- bench.sh | bash

   else
       echo No
       clear
       echo "Did not run benchmark and information"
       echo
   fi

   read -n 1 -s -r -p "Press any key to continue "
   clear
   ;;

   "2)")
   echo "Do you want to run ADVANCED benchmark and information? (y/n)? "
   old_stty_cfg=$(stty -g)
   stty raw -echo
   answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
   stty $old_stty_cfg
   if echo "$answer" | grep -iq "^y" ;then
       echo Yes;

       curl -LsO raw.githubusercontent.com/thecreatorzone/plexguide-bench/master/bench.sh; chmod +x bench.sh; chmod +x bench.sh
       echo
       ./bench.sh -a

     else
       echo No
       clear
       echo "Did not run benchmark and information"
       echo
     fi

     read -n 1 -s -r -p "Press any key to continue "
     clear
     ;;

  "3)")
  bash /opt/plexguide/scripts/menus/bench-custom.sh
  ;;

  "4)")
  echo "Do you want to run a Speedtest? (y/n)? "
  old_stty_cfg=$(stty -g)
  stty raw -echo
  answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
  stty $old_stty_cfg
  if echo "$answer" | grep -iq "^y" ;then
      echo Yes;

      pip install speedtest-cli

      echo
      speedtest-cli

    else
      echo No
      clear
      echo "Did not run Speedtest"
      echo
    fi

    read -n 1 -s -r -p "Press any key to continue "
    clear
    ;;

  "5)")
     clear
     exit 0
     ;;
esac
done
exit
