Densha de Go! Plug & Play PC Controller Mod
===========================================

This mod allows you to convert your Densha de Go! Plug & Play into a Densha de
Go! Type 2 USB controller for PC (DGOC-44U).

Requirements
------------
You will need a USB drive and a powered USB OTG hub for installation.

The USB OTG hub I use can be found [here](https://www.amazon.ca/gp/product/B07BDJN76M).
You can also use an angle adapter instead of a hub, but I find the quality
inconsistent, meaning that sometimes it may not make contact properly and cause
issues.

Installation
------------
1. Prepare a USB drive by formatting it with a single FAT32 partition. Please
   search online if you need instructions on how to do this.
2. Copy the contents of this repo to the root of the USB drive.
3. Plug the drive into the USB OTG hub, then the hub into the micro USB port of
   the Plug & Play, and the power cable into the hub. Turn the Plug & Play on.
4. The door light will turn on to show that the installation has begun. Once
   the installation has completed, the Plug & Play will turn off. Turn the
   power switch off.
5. Unplug the USB OTG hub and connect the Plug & Play to your PC.

Usage
-----
To start in controller mode, plug the Plug & Play to your PC and hold the right
directional button. Switch on the Plug & Play. When you hear the hardware
connect sound from your computer, you can release the button. You should now be
able to configure your games to use the Plug & Play as a normal Type 2 USB
controller.

The input has been modified slightly from an actual DGOC-44U's operation. For
the emergency brake notch, it will only be triggered when you move the handle
into the notch in the emergency section rather than when you just move into the
section. When releasing emergency brakes, it will remain in the emergency notch
until you have moved the handle into B8. This helps prevent accidentally
engaging emergency brakes if you push slightly past B8.

Note that the original USB controller does not have a D-pad. Instead, the ABCD
buttons serve as directional buttons when SELECT is held. This does not work in
all circumstances (such as for looking around when stopping the train). This
mod emulated this mechanism for the directional buttons, so the same limitations
apply.

The power switch operates as normal for turning the Plug & Play off. If you
want to play the Plug & Play itself, turn it on without holding the right
directional button. Don't press the right button within 5 seconds of the game
starting up to avoid entering controller mode.

Note
----
This mod also enables RNDIS on the Plug & Play. You can access SSH on the Plug
& Play at 169.254.215.100. SFTP is not supported out of the box, but SCP is
available. The rootfs is mounted read-only by default. If you need to write
to rootfs, please remount it read-write with `mount -o remount,rw /`.

Kernel source code available [here](https://github.com/GMMan/dengo-plug-and-play-kernel).
