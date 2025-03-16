

```
root@orangepizero:~# find /lib/modules/*/kernel/drivers/i2c/|grep \.ko|sed 's_.*/__'|sed 's_.ko__'
i2c-slave-eeprom
i2c-algo-bit
i2c-mux-pinctrl
i2c-mux-pca9541
i2c-mux-pca954x
i2c-demux-pinctrl
i2c-mux-reg
i2c-mux-gpio
i2c-arb-gpio-challenge
i2c-stub
i2c-cp2615
i2c-fsi
i2c-tiny-usb
i2c-emev2
i2c-sun6i-p2wi
i2c-virtio
i2c-dln2
```


```
root@orangepizero:~# for i in `find /lib/modules/*/kernel/drivers/i2c/|grep \.ko|sed 's_.*/__'|sed 's_.ko__'`;do echo $i && modprobe $i || true;done
i2c-slave-eeprom
i2c-algo-bit
i2c-mux-pinctrl
i2c-mux-pca9541
i2c-mux-pca954x
i2c-demux-pinctrl
i2c-mux-reg
i2c-mux-gpio
i2c-arb-gpio-challenge
i2c-stub
modprobe: ERROR: could not insert 'i2c_stub': No such device
i2c-cp2615
i2c-fsi
i2c-tiny-usb
i2c-emev2
i2c-sun6i-p2wi
i2c-virtio
i2c-dln2
```

