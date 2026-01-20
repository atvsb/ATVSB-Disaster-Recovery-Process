# Linux Distribution Download Automation

This directory contains scripts to automate the verified download of various Linux distributions for disaster recovery and live CD/installation purposes.

## Features

- **Automated Downloads**: Download multiple Linux distributions with a single command
- **Checksum Verification**: Automatically verify downloads using SHA256 checksums
- **Resume Support**: Resume interrupted downloads automatically
- **Multiple Distributions**: Support for Ubuntu, Debian, Fedora, Rocky Linux, Arch Linux, and Linux Mint
- **Configurable**: Easy-to-modify configuration file for versions and mirrors
- **Progress Indicators**: Real-time download progress feedback

## Supported Distributions

| Distribution | Type | Default Version | Architecture |
|--------------|------|-----------------|--------------|
| Ubuntu       | Desktop (LTS) | 22.04.3 | amd64 |
| Debian       | Netinst | 12.4.0 | amd64 |
| Fedora       | Workstation | 39 | x86_64 |
| Rocky Linux  | Minimal | 9.3 | x86_64 |
| Arch Linux   | Latest | Rolling | x86_64 |
| Linux Mint   | Cinnamon | 21.3 | 64bit |

## Prerequisites

The script requires one of the following download tools:
- `wget` (recommended) or
- `curl`

And one of the following for checksum verification:
- `sha256sum` (recommended) or
- `shasum`

### Installing Prerequisites

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install wget
```

**Fedora/Rocky Linux:**
```bash
sudo dnf install wget
```

**Arch Linux:**
```bash
sudo pacman -S wget
```

## Usage

### Basic Usage

Make the script executable:
```bash
chmod +x download_distros.sh
```

Download a specific distribution:
```bash
./download_distros.sh -d ubuntu
./download_distros.sh -d debian
./download_distros.sh -d fedora
```

Download all distributions:
```bash
./download_distros.sh -a
```

### Advanced Options

List available distributions:
```bash
./download_distros.sh -l
```

Specify custom output directory:
```bash
./download_distros.sh -d ubuntu -o /path/to/downloads
```

Skip checksum verification (not recommended):
```bash
./download_distros.sh -d debian --no-verify
```

Show help:
```bash
./download_distros.sh -h
```

## Configuration

Edit `distro_config.conf` to customize:
- Distribution versions
- Architecture preferences
- Mirror URLs
- Default output directory

Example:
```bash
# Change Ubuntu version
UBUNTU_VERSION=22.04.3

# Change output directory
DEFAULT_OUTPUT_DIR=/mnt/isos
```

## File Structure

```
.
├── download_distros.sh      # Main download script
├── distro_config.conf        # Configuration file
└── DOWNLOAD_GUIDE.md         # This file
```

## Download Process

For each distribution, the script:

1. **Creates output directory** if it doesn't exist
2. **Checks for existing file** to avoid re-downloading
3. **Downloads ISO image** from official mirrors
4. **Downloads checksum file** (SHA256SUMS or equivalent)
5. **Verifies checksum** to ensure integrity
6. **Reports success or failure** with colored output

## Verification Details

The script uses SHA256 checksums to verify download integrity:

- **Ubuntu**: Downloads SHA256SUMS from releases.ubuntu.com
- **Debian**: Downloads SHA256SUMS from cdimage.debian.org
- **Fedora**: Downloads CHECKSUM file (manual verification recommended)
- **Rocky Linux**: Downloads CHECKSUM file with SHA256 hashes
- **Arch Linux**: Downloads sha256sums.txt from mirror
- **Linux Mint**: Downloads sha256sum.txt from mirror

## Troubleshooting

### Download Fails

If a download fails:
1. Check your internet connection
2. Try a different mirror (edit URLs in script)
3. Ensure you have enough disk space
4. Run the script again (downloads will resume)

### Checksum Verification Fails

If checksum verification fails:
1. Delete the corrupted file
2. Re-run the download
3. If it fails again, the mirror might have issues
4. Try a different mirror or download manually

### Permission Denied

If you get permission errors:
```bash
chmod +x download_distros.sh
```

Or run with sudo if writing to protected directories:
```bash
sudo ./download_distros.sh -d ubuntu -o /opt/isos
```

## Security Considerations

- **Always verify checksums**: The script enables verification by default
- **Use official mirrors**: The script uses official distribution mirrors
- **Check GPG signatures**: For maximum security, manually verify GPG signatures after download
- **Secure storage**: Store downloaded ISOs in a secure location
- **Regular updates**: Update the configuration to download latest versions

## Example Workflows

### Disaster Recovery Kit

Download essential distributions for recovery:
```bash
# Create recovery ISO directory
mkdir -p /backup/recovery-isos

# Download critical distributions
./download_distros.sh -d ubuntu -o /backup/recovery-isos
./download_distros.sh -d debian -o /backup/recovery-isos
./download_distros.sh -d rocky -o /backup/recovery-isos
```

### Complete ISO Collection

Download all supported distributions:
```bash
./download_distros.sh -a -o /mnt/storage/isos
```

### Automated Updates

Create a cron job to update ISOs monthly:
```bash
# Edit crontab
crontab -e

# Add monthly download (1st of each month at 2 AM)
0 2 1 * * /path/to/download_distros.sh -a -o /backup/isos
```

## Creating Bootable Media

After downloading, create bootable USB/DVD:

### Using `dd` (Linux):
```bash
sudo dd if=ubuntu-22.04.3-desktop-amd64.iso of=/dev/sdX bs=4M status=progress
sudo sync
```

### Using `Rufus` (Windows):
1. Download Rufus from https://rufus.ie
2. Select the ISO file
3. Select target USB drive
4. Click "Start"

### Using `Etcher` (Cross-platform):
1. Download Etcher from https://www.balena.io/etcher/
2. Select the ISO file
3. Select target drive
4. Click "Flash"

## Contributing

To add support for additional distributions:

1. Add a `download_<distro>` function in `download_distros.sh`
2. Update the `list_distributions` function
3. Add configuration in `distro_config.conf`
4. Update this documentation

## Resources

### Official Distribution Sites

- **Ubuntu**: https://ubuntu.com/download
- **Debian**: https://www.debian.org/distrib/
- **Fedora**: https://getfedora.org/
- **Rocky Linux**: https://rockylinux.org/download
- **Arch Linux**: https://archlinux.org/download/
- **Linux Mint**: https://linuxmint.com/download.php

### Mirrors

For better download speeds, you can modify mirror URLs in the script:
- Ubuntu Mirrors: https://launchpad.net/ubuntu/+cdmirrors
- Debian Mirrors: https://www.debian.org/mirror/list
- Fedora Mirrors: https://admin.fedoraproject.org/mirrormanager/
- Arch Linux Mirrors: https://archlinux.org/mirrors/

## License

This script is released under the MIT License. See the LICENSE file in the repository root for details.

## Disaster Recovery Considerations

These scripts are designed for disaster recovery scenarios where you may need to:

- **Quickly deploy new systems** using live CDs
- **Rescue data** from failing systems
- **Rebuild infrastructure** after hardware failure
- **Test different distributions** for compatibility
- **Maintain offline installation media** for air-gapped environments

### Recommended Practices

1. **Regular Updates**: Download new ISOs quarterly or when security updates are released
2. **Multiple Copies**: Maintain copies on different media (USB, DVD, network storage)
3. **Version Documentation**: Keep records of which versions you have downloaded
4. **Test Media**: Regularly test that your bootable media works
5. **Offline Storage**: Keep copies offline for true disaster scenarios

## Support

For issues or questions:
1. Check this documentation
2. Review the script comments
3. Open an issue on the repository
4. Consult distribution-specific documentation
