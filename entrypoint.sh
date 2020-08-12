#! /bin/sh

TIME=`date +%Y%m%d-%H%M%S`
echo "[INFO]Start Time: $TIME"

SRVNO=1
echo "[INFO]Display : $SRVNO"

RR=$1
if [ "$RR"x = "null"x ]; then
  RR=1290x730x24
fi

RR_X=$2
if [ "$RR_X"x = "null"x ]; then
  RR_X=1290
fi

RR_Y=$3
if [ "$RR_Y"x = "null"x ]; then
  RR_Y=730
fi
echo "[INFO]Resolution Ratio: $RR"
echo "[INFO]RR_X: $RR_X"
echo "[INFO]RR_Y: $RR_Y"

PSNO=`ls /tmp |grep "Xvfb_screen0" |wc -l` && echo "[log]Xvfb :$SRVNO file exist : $PSNO"

# If file Xvfb_screen0 exist, then kill xvfb process.
until [ $PSNO -eq 0 ]
  do 
    ps -ef |grep "Xvfb :$SRVNO" |grep -v "grep" |awk '{print $2}' |xargs -r kill -2
    PSNO=`ls /tmp |grep "Xvfb_screen0" |wc -l`
    echo "[INFO]Wait 1 second for kill old Xvfb_screen0."
    sleep 1
done

# If file Xvfb_screen0 not exist, then start xvfb process.
until [ $PSNO -eq 1 ]
  do 
    Xvfb :$SRVNO -ac -screen 0 $RR -fbdir /tmp &
    PSNO=`ls /tmp |grep "Xvfb_screen0" |wc -l`
    echo "[INFO]Wait 1 second for start Xvfb_screen0."
    sleep 1
done

DISPLAY=:$SRVNO xdotool mousemove $RR_X $RR_Y
sleep 1
DISPLAY=:$SRVNO xdotool mousemove $RR_X $RR_Y
sleep 2
DISPLAY=:$SRVNO xdotool mousemove $RR_X $RR_Y

echo "[INFO]Xvfb_screen0 start success."

bash

