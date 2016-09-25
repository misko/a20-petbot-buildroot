#!/bin/bash
m="videobuf-core.ko videobuf-dma-contig.ko camera.ko ov5640.ko sunxi_csi0.ko"
for mm in $m ; do
        insmod /lib/modules/3.4.39/$mm
done
