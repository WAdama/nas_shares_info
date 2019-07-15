# nas_shares_info.sh

Bash script for PRTG by Paessler to monitor shares on a Synology NAS

nas_shares_info_b.sh is a version especially for BTRFS file system which uses the **btrfs filesystem du** command.

### Prerequisites

Be sure you have set correct logon values for SSH in your device.

I personally use "Login via private key" with an user especially for monitoring which also may use sudo for this script without a password.

![Screenshot1](https://github.com/WAdama/nas_shares_info/blob/master/images/ssh_settings.png)

**HINT:** Since DSM 6.2.2 for SSH access the user has to be member of the local Administrators group on your Synology NAS.

### Installing

Place the script to /var/prtg/scriptsxml on your Synology NAS and make it executable. (You may have to create this directory structure because PRTG expects the script here.)

```
wget https://raw.githubusercontent.com/WAdama/nas_shares_info/master/nas_shares_info.sh
or
wget https://raw.githubusercontent.com/WAdama/nas_shares_info/master/nas_shares_info_b.sh
chmod +x nas_shares_info.sh
```

In PRTG create under your device which represents your Synology a SSH custom advanced senor. 

Choose under "Script" this script and enter under "Parameters" the path and name to your configuration file.

![Screenshot1](https://github.com/WAdama/nas_shares_info/blob/master/images/nas_shares_info.png)

The configuration file must contain two entries:

```
VOLUME=volume1 #Volume where the shares are located
SHARES=(Share1 Share2 Share3) #The share(s) to monitor
```
For each share the script will at least create one channel. If you have activated the Recycle Bin for a share also a channel for this Recycle Bin will be created.

Based on how many shares and how big your shares are choose working timeouts and scanning interval for your sensor.

**HINT:** Beware of that the btrfs command runs much longer than the standard du. So if you have quite large shares together in one sensor it may reach a timeout in PRTG.

![Screenshot1](https://github.com/WAdama/nas_shares_info/blob/master/images/nas_shares_info_sensor.png)
