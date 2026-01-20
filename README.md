# ATVSB-Disaster-Recovery-Process

This public repository represents the open source instructions for informing and sharing technology and solutions in dangerous/disastrous situations.

## Linux Distribution Download Automation

This repository includes automated scripts to download and verify various Linux distributions for disaster recovery and live CD/installation purposes.

### Quick Start

```bash
# Make the script executable
chmod +x download_distros.sh

# Download a specific distribution
./download_distros.sh -d ubuntu

# Download all distributions
./download_distros.sh -a

# List available distributions
./download_distros.sh -l
```

### Supported Distributions

- **Ubuntu** - Desktop LTS (22.04.3)
- **Debian** - Stable netinst (12.4.0)
- **Fedora** - Workstation (39)
- **Rocky Linux** - Minimal (9.3)
- **Arch Linux** - Latest rolling release
- **Linux Mint** - Cinnamon (21.3)

### Features

✅ Automated downloads from official mirrors  
✅ SHA256 checksum verification  
✅ Resume interrupted downloads  
✅ Support for multiple distributions  
✅ Configurable versions and mirrors  
✅ Progress indicators  

### Documentation

For detailed usage instructions, see [DOWNLOAD_GUIDE.md](DOWNLOAD_GUIDE.md)

### Files

- `download_distros.sh` - Main download script
- `distro_config.conf` - Configuration file for versions and URLs
- `DOWNLOAD_GUIDE.md` - Comprehensive usage guide

manual instructions implemented so far...

For DIY computer repair I’m beginning instructions for low power/failed device restore for functionality and communication purposes.

Don’t feel bad if you don’t understand what I’ve written, this is why I’ve posted it…

Contribution links coming shortly

Here’s how far I’ve got for non-tech peeps to allegedly read through and action - suggestions for layout - info - links etc, GitHub profile being created.

Linux Process

Full process requires minimum of 3 USB drives 16-32 gb (32gb-128 preferable for newer machines check backup size/OS recovery drive info ( 3-5 yrs old eg)
1 USB = WINDOWS/APPLE/GOOGLE RESTORE
1 USB = TEXT DOCUMENTS + PASSWORD BACKUP 128GB+ REQUIRED FOR NEWER MACHINES PROBABLY eg “photoshop project files” “music production files”

1 USB PER LINUX DISTRO 
OR HARDER TO DO 1 LARGE MULTI DISTRO INSTALLER

2 factor authentication - ensure device being converted is not part of you’re “security chain” eg “Authenticator app” “text verification” eg watsapp etc if so, all 2FA logins require re registering to a different Authenticator app eg

Backup Locations:-

Login/Password files system:-settings and all browsers used Firefox:-settings-Password/logins Chrome:-settings-password/logins etc or “secrets managers”
Chat histories in chat apps
File history in chat apps (photos)
Authenticators 

Check all Desktop Folders

“My Documents”
 \Photos:Pictures
 \Music
 \”text” etc

Main Drive Root folders c:\ d:\. etc
Check specialist software directories eg C:\Photoshop eg etc

Copy all found user files to spare drive

OS Settings “create boot/install/recovery drive”

End of backup/recovery process-

This process is not required if you’re Linux usb installer is checked/verified/operational and ready for install 
AND the computer you are installing Linux on, has no operating system or data you wish to restore…

This section is only in regards to downloading software to create an installation disk and verify it for installation or “live testing use”

“Live testing” allows a computer to load Linux from USB *WITHOUT* installing over the internal hard drive, it can be tested in this state, then, SHUT DOWN computer - remove USB and boot computer - computer will be back to normal.

This Process DESTROYS EVERYTHING 
on the USB drive to create
USB Live/Install drive 
Warning is here to ensure you are using the CORRECT USB For the Linux drive creation!!!

LINUX LIVE/INSTALL USB DRIVE CREATION

Download Linux versions -  

choices are [fedora/redhat] [debian/ubuntu/mint] [arch/manjaro etc]
Smaller distros available for old/historic/ancient/custom/obscure hardware 

Download Linux Versions Product Code “Hash Key” usually same page as download or contained within a complete table covering all current downloadable versions for that distribution 

Run hashkey gen against downloaded Linux.iso

Find and open a terminal
 <really scary bit>

Power shell in windows
Terminal in mac
Terminal in WSL/WSL2

Download USB Writer Belenecher/ Rufus eg

Run USB Writer 

Insert blank usb - usb may ask to be formatted - format fat32 

Write iso to blank usb using DD method

Confirmed secure USB installation/live test drive created

USB Drive, in this state…
DOES NOT HAVE PERMENENT STORAGE

To enable persistent storage either create a second partition of 16gb+ and use that as data store, OR enable “Linux with persistence” at the rufus/belenecher iso write stage in the USB creation section

IF YOU PROCEED BEYOND THIS POINT WITHOUT TESTING USABILITY OF YOURE NEW USB AND PROCEED TO INTERNAL DRIVE INSTALL
ALL DATA WILL BE LOST

Shutdown computer leave usb drive in

All computers have a boot screen and a bios screen, the bios screen is internal computer settings that change your computers behaviour at the lowest level of operation.

Usually a menu on a function key usually labelled F1…F12 
Usually F1 F2 F9 F11 or F12

Power on with usb drive in and using manufacturer instructions for boot startup/bios access usually 1 of either 
F1 or F2 or F9 or F11 or F13 key held down immediately after power button pushed.

Depending Which Menus you have found (will be titled bios or boot etc)

If Boot screen found then…
Find + Select “Boot from USB”

If BIOS Menu found
Change boot order of drives 
Options external/internal/network-boot 
ENSURE External drive lists first in boot order.

This is also a security risk, to increase security of devices “boot from external/network” is usually disabled/restricted/loads after internal disks.

Once selected “boot from external drive”computer will load linux from USB drive where a “live” environment is available to explore prior to internal hard drive installation 

To install the Linux environment to the machine an option on the desktop or menu declares “install this <linux-distribution-name> to computer” eg 

The installation has a “guided installation method” where the software picks or informs you of the best and easiest options.

Or “choose your own adventure” installation method.

If you are installing Linux and it goes wrong, do not fear, shut down the computer, and reboot from you’re usb and begin again, google any screens or words you don’t understand and play with the settings you cannot really do any real long lasting significant damage that cannot be fixed unless the computer was going to break/fail anyway.

****Advanced Installation****

Options for install include 

Dual Boot
(keep win/osx/chrome) + install Linux
Option at boot for either OS

Hard disk configuration - 

storage can almost always be split into smaller  drives or “partitions”
E.G

1 usb or hard disk drive
Can be split into 2 or more spaces of equall or different sizes.
If you do this with an internal hard disk drive
Where the drive previously was “C:\” only - there will be a second partition with a new drive letter “D:\” each additional partition gets labelled with incremental letters except where another drive exists with a letter already ascribed eg CD-ROM drive being normally “E:\” or floppy disks previously sitting in A:\ and B:\ positions.

Linux (and other operating systems) offers the benefit of partitions to seperate data and functions, where d:\ can now be user space that doesn’t require “backup” for a new operating system to be installed.

If you choose advanced partition layout, all segments of the Linux-GNU environment will be spread across individual partitions or even seperate drives/storage media. This can make your user space “transportable by usb” eg.

Or allow the same files to exist in 2 different operating systems in a dual boot scenario

Firewall services are built in and can be started in the settings and configuration files

Google, apple, Microsoft have logins available either through web browser or application installations.

SOFTWARE and PROGRAMS and SERVICES 

Web browsers

chrome/firefox/microsoft edge/brave browser/safari are all available.

Libra office amongst others replace word/excel

Linux is a security conscious operating system.
Encryption for secure email and other communications can be configured using secure keys generated by the operating system. 2FA via an authenticator and password manager that IS NOT A BROWSER!!!

Browser password file stores are easier to get hijacked.

You’re operating system with have created a user with a password - the password is often required to allow actions - password requests can be more frequent due to the nature of the security and preventing you from a disastrous action that may not be able to be reversed, or an action that fundamentally changes you’re computer and operating system mode of operation.

