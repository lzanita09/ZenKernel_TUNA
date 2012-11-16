#!/tmp/busybox sh
cd /tmp
mkdir ramdisk
cd ramdisk
/tmp/busybox gzip -dc ../boot.img-ramdisk.gz | /tmp/busybox cpio -i
if [ -z `/tmp/busybox grep init.d init.rc` ]; then
if [ ! grep -q "run-parts /system/etc/init.d" init.rc ]; then
echo '' >> init.rc
echo 'service run_parts /sbin/bb/busybox run-parts /system/etc/init.d' >> init.rc
echo '	  class main' >> init.rc
echo '    oneshot' >> init.rc
fi
fi
rm /tmp/boot.img-ramdisk.gz
/tmp/busybox sh -c "/tmp/busybox find . | /tmp/busybox cpio -o -H newc | /tmp/busybox gzip > /tmp/boot.img-ramdisk.gz"
cd ../
