# putty.exe -ssh user@192.168.1.1 -pw password -m C:\local\file\containing_command
#!/bin/sh

DIRECTORY="xmr-stak-cpu"

cd #s tart from home

# if dir doesnt exist we need to install
if [ ! -d $DIRECTORY ]; then 
    # dependencies  
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test
    sudo apt update
    sudo apt --yes install gcc-5 g++-5 make
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 1 --slave /usr/bin/g++ g++ /usr/bin/g++-5
    curl -L http://www.cmake.org/files/v3.4/cmake-3.4.1.tar.gz | tar -xvzf - -C /tmp/
    cd /tmp/cmake-3.4.1/ && ./configure && make && sudo make install && cd -
    sudo update-alternatives --install /usr/bin/cmake cmake /usr/local/bin/cmake 1 --force
    sudo apt --yes install libmicrohttpd-dev libssl-dev libhwloc-dev
    # clone and build
    git clone https://github.com/fireice-uk/xmr-stak-cpu.git
    cd xmr-stak-cpu
    cmake .
    make install
    # setup config file
    cd bin
    mv config.txt config.txt.og
    git clone https://github.com/YanBellavance/xmr-stak-cpu-config-txt-script-files.git
    CONFIG_TXT_INPUT="configPyTemplate.txt"
    CONFIG_TXT_OUTPUT="../config.txt"
    NUM_CORES=$(getconf _NPROCESSORS_ONLN)
    USER_ID_APPEND=$(curl ipinfo.io/ip | tr "." "_")
    ./setupConfig.py -i $CONFIG_TXT_INPUT -o $CONFIG_TXT_OUTPUT  -c $NUM_CORES -u $USER_ID
    # launch 
    ./xmr-stak-cpu
    # manual check of hash rate (many cores sometimes dont launch right and give like 0H/s)
    
  fi
fi