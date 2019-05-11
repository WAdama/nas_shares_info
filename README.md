# nas_shares_info.sh

Bash script for PRTG by Paessler to monitor shares on a Synology NAS

### Prerequisites

Be sure you have set correct logon values for SSH in your device.

I personally use "Login via private key" with an user especially for monitoring which also may use sudo for this script without a password.

![Screenshot1](https://github.com/WAdama/nas_shares_info/blob/master/images/ssh_settings.png)

### Installing

Place the script to /var/prtg/scriptsxml on your Synology NAS.

In PRTG create under your device which represents your Synology a SSH custom advanced senor. 

Choose under "Script" this script and enter under "Parameters" the path and name to your configuration file.

![Screenshot1](https://github.com/WAdama/nas_shares_info/blob/master/images/nas_shares_info.png)

The configuration file contains two entries:

```
VOLUME=volume1 #Volume where the shares are located
SHARES=(Share1 Share2 Share3) #The share(s) to monitor
```
For each share the sensor will at least one channel. If you have activated the Recycle Bin for a share also a channel for this Recycle Bin will be created.

Based on how many shares and how big your shares are choose working timeouts and scanning interval for your sensor.

I use in this script custom units which show the share use in giga bytes. I wanted to use standard units from the custom sensor but I can't got it running to show correct values.

![Screenshot1](https://github.com/WAdama/nas_shares_info/blob/master/images/nas_shares_info_sensor.png)
