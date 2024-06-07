FROM docker.io/archlinux/archlinux

RUN pacman-key --init \
 && pacman -Syu --noconfirm \
 && pacman -S --noconfirm gcc make automake autoconf git \
    wget tmux openssh \
 && rm /var/cache/pacman/pkg/* \
 && cd /root \
 && git clone https://github.com/LekKit/RVVM.git \
 && cd RVVM \
 && make -j $(nproc) USE_NET=1 USE_FB=0 USE_SDL=0 \
    CFLAGS="-mtune=native" LDFLAGS='-static' \
 && mv release.linux.x86_64/rvvm_x86_64 /root \
 && cd /root \
 && rm -rf RVVM \
 && pacman -Rsc --noconfirm gcc make automake autoconf git

ADD fw_jump.bin /root/fw_jump.bin
ADD linux-6.9.3-rvvm /root/linux-6.9.3-rvvm

