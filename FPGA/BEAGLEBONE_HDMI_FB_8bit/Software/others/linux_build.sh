export PATH=$HOME/ti-sdk-am335x-evm-06.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin:$PATH
cd ~/ti-sdk-am335x-evm-06.00.00.00/board-support/linux-3.2.0-psp04.06.00.11
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage