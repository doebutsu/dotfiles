parted /dev/nvme0n1 << EOF
mklabel gpt
mkpart primary fat32 1MiB 513MiB
set 1 esp on
name 1 EFI
mkpart primary linux-swap 513MiB 16GiB
name 2 swap
mkpart primary ext4 16GiB 100%
name 3 root
quit
EOF
mkfs.vfat -F 32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
swapon /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3
mkdir --parents /mnt/gentoo
mount /dev/nvme0n1p3 /mnt/gentoo
mkdir --parents /mnt/gentoo/efi
mount /dev/nvme0n1p1 /mnt/gentoo/efi
wget --directory-prefix=/mnt/gentoo https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-musl-llvm/$(curl --silent https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-musl-llvm/latest-stage3-amd64-musl-llvm.txt | grep --only-matching '.*.tar.xz')
tar xpvf /mnt/gentoo/*.tar.xz --xattrs-include='*.*' --numeric-owner --directory=/mnt/gentoo
rm --force /mnt/gentoo/*.tar.xz
cp --recursive ./root/* /mnt/gentoo/
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/
arch-chroot /mnt/gentoo /bin/bash -c 'emerge --sync'
arch-chroot /mnt/gentoo /bin/bash -c 'emerge --verbose --update --deep --newuse @world'
arch-chroot /mnt/gentoo /bin/bash -c 'emerge --deepclen'
arch-chroot /mnt/gentoo /bin/bash -c 'rc-update add iwd default'
arch-chroot /mnt/gentoo /bin/bash -c 'rc-update add dhcpcd default'
arch-chroot /mnt/gentoo /bin/bash -c 'rc-update add sysklogd default'
arch-chroot /mnt/gentoo /bin/bash -c 'rc-update add chronyd default'
arch-chroot /mnt/gentoo /bin/bash -c 'rc-update add elogind boot'
arch-chroot /mnt/gentoo /bin/bash -c 'echo "root:CHANGEME" | chpasswd'
arch-chroot /mnt/gentoo /bin/bash -c 'useradd -m -G users,wheel,audio -s /bin/bash lain'
arch-chroot /mnt/gentoo /bin/bash -c 'echo "lain:CHANGEME" | chpasswd'
arch-chroot /mnt/gentoo /bin/bash -c 'genfstab -U / >> /etc/fstab'
arch-chroot /mnt/gentoo /bin/bash -c 'grub-install --efi-directory=/efi'
arch-chroot /mnt/gentoo /bin/bash -c 'grub-mkconfig -o /boot/grub/grub.cfg'
