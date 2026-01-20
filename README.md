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
