# putty.exe -ssh user@192.168.1.1 -pw password -m C:\local\file\containing_command
#!/bin/sh

DIRECTORY="xmr-stak-cpu"

cd # start from home
cd xmr-stak-cpu
cd bin
screen -q -d -m ./xmr-stak-cpu
echo done. press any key to continue
read -n 1 -s -r -p "Press any key to continue"  