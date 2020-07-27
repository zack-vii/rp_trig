# RP_TRIG

A versatile trigger manipulator for RedPitaya.

## Generate bitstream for FPGA

1. Open vivado (project designed for Vivado 2020.1)
2. Open project './logic/rp_trig.xpr'
3. Generate Bitstream

## Install

```
Installation on a fresh original RedPitaya Image:
RP=RP-123456.local
ssh-copy-id root@$RP # password is root
ssh root@$RP /usr/bin/passwd
ssh root@$RP apt-get update
ssh root@$RP apt-get -y install python-numpy kmod
ssh root@$RP apt-get clean
./deploy $RP 1
```
