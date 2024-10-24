# nas_shares_info.sh

Bash script for PRTG by Paessler to monitor shares on a Synology NAS

nas_shares_info_b.sh is a version especially for BTRFS file system which uses the **btrfs filesystem du** command.

Sensor has to be created in PRTG on your Synology device.

Sensor tested on DS 918+ with DSM 6.2.4-25556 and 7.0-41890

**Note:** As "source" can be misused in bash scripts, I have changed the conf file to JSON format. If you want to update to the new script, pause your sensor(s), change to the new script and recreate your conf files in JSON format with the same shares to be monitored. Then just resume the sensor(s).

### Prerequisites

Be sure you have set correct logon values for SSH in your device.

I personally use "Login via private key" with an user especially for monitoring which also may use sudo for this script without a password.

![Screenshot1](./images/ssh_settings.png)

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

![Screenshot1](./images/nas_shares_info.png)

The configuration file must contain entries for volume and shares in JSON format:

```
{
  "VOLUME": "volume1",
  "SHARES": [
    "Share1",
    "Share2",
    "Share3"
  ]
}
```
For each share the script will at least create one channel. If you have activated the Recycle Bin for a share also a channel for this Recycle Bin will be created.

Based on how many shares and how big your shares are choose working timeouts and scanning interval for your sensor.

**HINT:** Beware of that the btrfs command runs much longer than the standard du. So if you have quite large shares together in one sensor it may reach a timeout in PRTG.

![Screenshot1](./images/nas_shares_info_sensor2.PNG)
