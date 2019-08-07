chmod -R 775 /harts/config/ICE7660_MODEM.zip
cd /harts/current/hil-2.0.0.3/tools/
./dut-power-off
sleep 2
./dut-power-on
sleep 3
cd /harts/current/bin/
./DownloadTool -c /dev/iat --flashless-path /harts/config/NVM_DATA/ -z /harts/config/ICE7660_MODEM.zip
sleep 3
cd /harts/current/imc_ipc_*/
./imc_start
