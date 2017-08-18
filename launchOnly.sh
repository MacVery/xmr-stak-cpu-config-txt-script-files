# putty.exe -ssh user@192.168.1.1 -pw password -m C:\local\file\containing_command
#!/bin/sh

DIRECTORY="xmr-stak-cpu"

cd # start from home
cd xmr-stak-cpu
cd bin
screen -q -D -X exec ./xmr-stak-cpu
