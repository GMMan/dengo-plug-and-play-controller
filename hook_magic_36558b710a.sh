#!/bin/sh

# Densha de Go! Plug & Play controller mod installation script

USB_ROOT="/mnt"

error_exit() {
    # Blink the door light to indicate an error
    echo timer > /sys/class/leds/led2/trigger
    echo 100 > /sys/class/leds/led2/delay_on
    echo 100 > /sys/class/leds/led2/delay_off
    exit 1
}

{

# Stop Densha de Go! game app
/etc/init.d/S99dgtype3 stop

# Light the door light to indicate we're running
echo -n none > /sys/class/leds/led2/trigger
echo 1 > /sys/class/leds/led2/brightness

# Mount partitions
mkdir /tmp/boot
if ! mount /dev/mmcblk0p6 /tmp/boot; then
    echo "Failed to mount boot partition"
    error_exit
fi

if ! mount -o remount,rw /; then
    echo "Failed to remount rootfs read-write"
    error_exit
fi

# Backup original kernel
if [ ! -f "${USB_ROOT}/uImage" ]; then
    if ! cp /tmp/boot/uImage "${USB_ROOT}"; then
        echo "Failed to backup original kernel"
        rm -f "${USB_ROOT}/uImage"
        error_exit
    fi
fi

# Replace kernel
if ! cp -f "${USB_ROOT}/payload/uImage" /tmp/boot/uImage; then
    echo "Failed to replace kernel"
    if ! cp -f "${USB_ROOT}/uImage" /tmp/boot/uImage; then
        echo "Failed to restore original kernel"
    fi
    error_exit
fi

# Backup original mali.ko
if [ ! -f "${USB_ROOT}/mali.ko" ]; then
    if ! cp /lib/modules/3.4.113/extra/mali.ko "${USB_ROOT}"; then
        echo "Failed to backup original mali.ko"
        rm -f "${USB_ROOT}/mali.ko"
        error_exit
    fi
fi

# Replace mali.ko
if ! cp -f "${USB_ROOT}/payload/mali.ko" /lib/modules/3.4.113/extra/mali.ko; then
    echo "Failed to replace mali.ko"
    if ! cp -f "${USB_ROOT}/mali.ko" /lib/modules/3.4.113/extra/mali.ko; then
        echo "Failed to restore original mali.ko"
    fi
    error_exit
fi

chmod 644 /lib/modules/3.4.113/extra/mali.ko

# Install files
if ! cp -f "${USB_ROOT}/payload/libevdev.so.2" /usr/lib; then
    echo "Failed to install library"
    error_exit
fi

chmod 755 /usr/lib/libevdev.so.2

if ! cp -f "${USB_ROOT}/payload/input_relay" /usr/bin; then
    echo "Failed to install input relay"
    error_exit
fi

chmod 755 /usr/bin/input_relay

if ! cp -f "${USB_ROOT}/payload/S40usbotg" /etc/init.d; then
    echo "Failed to install init script"
    error_exit
fi

chmod 755 /etc/init.d/S40usbotg

echo "Installation complete"

# We're done
poweroff

} > "${USB_ROOT}/log.txt" 2>&1
