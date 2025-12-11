DRIVES=($(lsblk -d -n -o NAME,SIZE))
ITEMS=()
for ((i=0; i<${#DRIVES[@]}; i+=2)); do 
    ITEMS+=("$((i/2+1))" "/dev/${DRIVES[i]} (${DRIVES[i+1]})")
done

if CHOICE=$(dialog --clear  --ok-label "Next" --menu "Select drive:" 15 50 ${#ITEMS[@]} "${ITEMS[@]}" 3>&1 1>&2 2>&3); then
    DRIVE="${DRIVES[$((CHOICE*2-2))]}"
else
    exit 0
fi

SEPARATOR=""
if [[ $DRIVE == *"nvme"* ]]; then
    SEPARATOR="p"
fi

if USERNAME=$(dialog --clear  --ok-label "Next" --inputbox "Enter username:" 8 40 3>&1 1>&2 2>&3); then
    if [ -z "$USERNAME" ]; then
        dialog --clear  --msgbox "Username cannot be empty!" 10 40
        exit 1
    fi
else
    exit 0
fi

if USERNAME_PASSWORD=$(dialog --clear  --ok-label "Next" --inputbox "Enter username password:" 8 40 3>&1 1>&2 2>&3); then
    if [ -z "$USERNAME_PASSWORD" ]; then
        dialog --clear  --msgbox "Username password cannot be empty!" 10 40
        exit 1
    fi
else
    exit 0
fi

if ROOT_PASSWORD=$(dialog --clear  --ok-label "Next" --inputbox "Enter root password:" 8 40 3>&1 1>&2 2>&3); then
    if [ -z "$ROOT_PASSWORD" ]; then
        dialog --clear  --msgbox "Root password cannot be empty!" 10 40
        exit 1
    fi
else
    exit 0
fi

clear

git clone https://github.com/ohmyzsh/ohmyzsh.git ./root/usr/share/oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ./root/usr/share/oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/alexanderjeurissen/ranger_devicons.git ./root/etc/skel/.config/ranger/plugins/ranger_devi
echo "default_linemode devicons" >> ./root/etc/skel/.config/ranger/rc.conf

wipefs --all /dev/"$DRIVE"
parted /dev/"$DRIVE" mklabel gpt
parted /dev/"$DRIVE" mkpart primary fat32 1MiB 1024MiB
parted /dev/"$DRIVE" set 1 esp on
parted /dev/"$DRIVE" mkpart primary ext4 1024MiB 100%
yes | mkfs.vfat /dev/"$DRIVE""$SEPARATOR"1
yes | mkfs.ext4 /dev/"$DRIVE""$SEPARATOR"2

mount /dev/"$DRIVE""$SEPARATOR"2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/"$DRIVE""$SEPARATOR"1 /mnt/boot/efi

pacstrap /mnt base base-devel linux linux-firmware linux-headers openssh grub efibootmgr networkmanager firefox wayland zsh git neovim swaybg pulseaudio alsa-lib alsa-utils pulsemixer gnome-boxes sway seatd waybar grim wl-clipboard ranger kitty ripgrep lazygit ttc-iosevka ttf-iosevka-nerd

cp -af ./root/* /mnt/

arch-chroot /mnt /bin/zsh -c "useradd -m -s /bin/zsh $USERNAME"
arch-chroot /mnt /bin/zsh -c "echo '$USERNAME:$USERNAME_PASSWORD' | chpasswd"
arch-chroot /mnt /bin/zsh -c "echo '$USERNAME ALL=(ALL:ALL) ALL' | tee -a /etc/sudoers"
echo "$USERNAME" > /mnt/etc/hostname

arch-chroot /mnt /bin/zsh -c "systemctl enable NetworkManager"

arch-chroot /mnt /bin/zsh -c "timedatectl set-timezone Europe/Moscow"
arch-chroot /mnt /bin/zsh -c "timedatectl set-ntp true"

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt /bin/zsh -c "grub-install /dev/$DRIVE"
arch-chroot /mnt /bin/zsh -c "grub-mkconfig -o /boot/grub/grub.cfg"

arch-chroot /mnt /bin/zsh -c "chsh -s /bin/zsh root"
arch-chroot /mnt /bin/zsh -c "echo 'root:$ROOT_PASSWORD' | chpasswd"
