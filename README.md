# Saving
konsave -s kde_konsave
konsave -e kde_konsave -d . -n desktop_backup


#### Backup package in official repository
```bash
pacman -Qqen > pkglist-repo.txt
```

#### Backup package in arch user repository (AUR)
```bash
pacman -Qqem > pkglist-aur.txt
```

# Restore
konsave -i desktop_backup
konsave -a kde_konsave

### To restore / re-install all of your package
#### For repository package
```bash
sudo pacman -S --needed - < pkglist-repo.txt
```

#### For AUR package
```bash
for x in $(< pkglist-aur.txt); do yay -S $x; done
```
