# Reckless exFAT Formatter
Ever wanted to recklessly format any USB drive plugged into your Raspberry Pi into exFAT? 

*Now you can!*

Reckless exFAT Formatter is a Bash script that attempts to quickly format any plugged in USB drive into exFAT. It also will write a customizable `info.txt` to the USB drive once finished. 

Don't like exFAT? Reckless exFAT Formatter is easy to customize to your needs. It's literally just Bash commands. Open it up and edit the `_formatDrive()` function with the command of your choice.



## How to install
### Prerequisites
- `exfat-fuse`
- `exfat-utils`

Install with:
```console
sudo apt-get install exfat-fuse
sudo apt-get install exfat-utils
```
### Setup Udev rules
This script is triggered by Udev. So lets create a Udev rule to detect when a USB drive is plugged in.  

#### Steps
1. Create and open the `.rules` file.
```console
sudo nano /etc/udev/rules.d/99-reckless-formatter.rules
```

2. Add this rule to the file. (It will be the only one there)
```console
ACTION=="add", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", RUN+="/usr/local/bin/reckless-formatter.sh"
```

3. Save and exit Nano. 

Press `ctrl + x` to save.

Press `y` to confirm

Press `Enter` to exit.

### Setup the script
Download `reckless-formatter.sh` and place it in `/usr/local/bin/`

*For example*
```console
sudo mv ~/Downloads/reckless-formatter.sh /usr/local/bin/reckless-formatter.sh
```
You can now customize the name and info of formatted USB sticks by editing the `_formatDrive()` and `_writeInfo()` functions. 

```console
sudo nano /usr/local/bin/reckless-formatter.sh
```

Once you're happy with your customizations you can give the script executable permissions. 

```console
sudo chmod +x /usr/local/bin/reckless-formatter.sh
```

You are now ready to recklessly format drives!

## Usage
1. Plug in USB drive.
2. Wait between 10 and 60 seconds.
3. Unplug the drive. 


## Other Thoughts
Running this script is a bad idea for most people. Unless you know that you need something specifically like this, I recommend you either create your own or use something else. 

Currently there is a 5 second window of time for you to remove the drive before it is formatted. 

This is **NOT** a security tool! Your data is not securely removed when using this script.