sudo apt update -y
sudo apt upgrade -y
sudo apt install mc -y
sudo apt install htop -y
sudo apt install python3-full -y
sudo apt install python3-pip -y
sudo apt install git -y
sudo pip install mppsolar --break-system-packages
sudo git clone https://github.com/bratwiz/jbdtool
cd jbdtool
# EDIT MAKE FILE AND SET 
# DEBUG=yes
# BLUETOOTH=no
# MQTT=no


sudo touch  /etc/systemd/system/SOLAR.service
sudo echo "
[Unit]
Description = SOLAR

[Service]
User = pi
Group = pi
ExecStart = /home/pi/SOLAR.sh
Restart = always
RestartSec = 5

[Install]
WantedBy=multi-user.target"

sudo systemctl enable SOLAR
sudo systemctl restart SOLAR
