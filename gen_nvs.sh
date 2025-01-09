#!/bin/bash

# Container or host?
if [ -f /.dockerenv ]; then
    /opt/esp/idf/components/nvs_flash/nvs_partition_generator/nvs_partition_gen.py generate \
	 --version 2 nvs.csv nvs.bin 0x24000
else
    esptool.py --port /dev/ttyACM0 write_flash 0x9000 nvs.bin
fi

