# nixos-cfg

NixOS Configuration - Modular, Scalable & Minimal

## Installation

### 1. Boot the NixOS ISO

Download the minimal ISO from https://nixos.org/download and flash it to a USB drive:

```bash
dd if=nixos-minimal-*.iso of=/dev/sdX bs=4M status=progress
```

Boot the target machine from the USB. Switch to a root shell:

```bash
sudo -i
```

### 2. Connect to the internet

```bash
# wired — usually works automatically via DHCP
ip a

# wifi
iwctl
  station wlan0 scan
  station wlan0 connect "SSID"
  exit
```

### 3. Partition and format with disko

> ⚠️ This **wipes `/dev/nvme0n1` completely**. Make sure you are targeting the right disk.

```bash
sudo nix run --extra-experimental-features "nix-command flakes" \
  github:nix-community/disko -- \
  --mode destroy,format,mount \
  --flake github:MasterEnderman/nixos-cfg#hp-probook
```

This creates and mounts:
```
- /boot — EFI partition (vfat, 512M)
- cryptroot — LUKS-encrypted btrfs partition
  - @nix → /nix
  - @persist → /persist
  - @swap → /.swapvol (16G swapfile)
- / — tmpfs (2G, wiped on every reboot)
```

### 4. Clone the config into persist

Since `/persist` is now mounted and will survive across reboots, clone the repo there directly:

```bash
git clone https://github.com/MasterEnderman/nixos-cfg.git /mnt/persist/etc/nixos
```

### 5. Regenerate hardware configuration

```bash
nixos-generate-config --root /mnt --show-hardware-config \
  > /persist/etc/nixos/modules/hosts/hp-probook/hardware-configuration.nix
```

Review the output before saving — make sure the initrd kernel modules look correct for your hardware.

### 6. Fix machine-id

```bash
# Generate a new UUID and write it to the file
uuidgen | tee /mnt/persist/etc/machine-id

# Set correct permissions (read-only for everyone)
chmod 444 /mnt/persist/etc/machine-id
```

### 7. Install

```bash
nixos-install --flake /mnt/etc/nixos#hp-probook --root /mnt
```

This will ask you to set a root password at the end. Set something temporary — you can disable root login after first boot.

### 8. Set the user password

```bash
nixos-enter --root /mnt -c 'passwd enderman'
```

⚠️ The default password for `enderman` user is currently `"password"` in `base.nix`. Change it immediately after first boot!

### 9. Commit the generated hardware config

```bash
cd /persist/etc/nixos
git add modules/hosts/hp-probook/hardware-configuration.nix
git commit -m "add hp-probook hardware configuration"
git push
```

### 10. Reboot

```bash
reboot
```

Remove the USB drive when the screen goes dark.

---

## First boot

### What to expect

```
1. systemd-boot presents the boot menu
2. You are prompted for the LUKS passphrase to decrypt the drive
3. Niri starts, noctalia-shell launches on top
```

### First things to do

**Verify persistence is working:**

```bash
findmnt | grep persist
```

**Verify the kernel:**

```bash
uname -r
# should include "cachyos" in the name
```

**Set up SSH keys** (if not restoring from backup):

```bash
ssh-keygen -t ed25519 -C "enderman@hp-probook"
# add ~/.ssh/id_ed25519.pub to GitHub
```

SSH keys are listed in the preservation module and will survive reboots once created.

**Disable root login** (recommended):

Add to `modules/nixos/features/common.nix`:

```nix
users.users.root.hashedPassword = "!";
```

Then rebuild:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#hp-probook
```

**Change your user password:**

```
passwd enderman
```

---

## Adding New Machines

To add a new host (e.g., `gaming-pc`), simply create the folder and files:

```
modules/nixos/hosts/gaming-pc/
├── default.nix         ← Copy from hp-probook, change hostname
├── disko.nix           ← Adjust disk path (/dev/nvme0n1 vs /dev/sda)
└── hardware-configuration.nix ← Run nixos-generate-config inside mount
```

Then add one line to `flake.nix`:

```
nixosConfigurations = {
  hp-probook = mkHost "hp-probook";
  gaming-pc = mkHost "gaming-pc";  # ← One line!
};
```

Home Manager runs the SAME profile (`enderman`) on ALL machines. No duplication needed.

---

## Common Commands

```
# Build and test without installing
nix build .#hp-probook

# Rebuild on running system
sudo nixos-rebuild switch --flake .#hp-probook

# Rollback if something breaks
sudo nixos-rebuild switch --rollback