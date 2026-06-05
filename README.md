# nixos-cfg
My n'th attempt at a proper nixos-config flake.

## First-time install
 
### 1. Boot the NixOS installer ISO
 
### 2. Clone this repo
```bash
git clone <your-repo> /mnt/etc/nixos   # or any path you prefer
cd /mnt/etc/nixos
```

### 3. Generate real hardware config
```bash
nixos-generate-config --show-hardware-config > hosts/yourhost/hardware-configuration.nix
```
 
### 4. Partition & format with disko
> ⚠️  This **wipes** the target disk.
```bash
sudo nix run github:nix-community/disko -- \
  --mode destroy,format,mount \
  ./hosts/yourhost/disko.nix
```
 
### 5. Install
```bash
sudo nixos-install --flake .#yourhost
```
 
### 6. Set user password
```bash
nixos-enter --root /mnt -c 'passwd youruser'
```

### 7. Reboot
```bash
reboot
```
