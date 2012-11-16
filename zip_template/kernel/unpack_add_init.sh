#!/tmp/busybox sh
cd /tmp
mkdir ramdisk
cd ramdisk
/tmp/busybox gzip -dc ../boot.img-ramdisk.gz | /tmp/busybox cpio -i
if [ ! grep -q "*system/etc/init.d*" init.rc ]; then
	echo '' >> init.rc
	echo 'service run_parts /system/sbin/bb/busybox run-parts /system/etc/init.d' >> init.rc
	echo '	  class main' >> init.rc
	echo '    oneshot' >> init if thei.rc
fi
rm ../boot.img-ramdisk.gz
/tmp/busybox sh -c "/tmp/busybox find . | /tmp/busybox cpio -o -H newc | /tmp/busybox gzip > ../boot.img-ramdisk.gz"
cd ..
