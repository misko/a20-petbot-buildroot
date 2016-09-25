all:
	#$(CC) $(CFLAGS) -o example example.c
	$(CC) $(CFLAGS) -mtune=cortex-a9 -march=armv7-a -mabi=aapcs-linux  -o example example.c
	@echo $(CONFIG_CHIP_ID)
	@echo "test make all"

install:
	install example $(TARGET_DIR)/bin
	@echo $(CONFIG_CHIP_ID)
	@echo "test make install"

clean:
	rm $(TARGET_DIR)/bin/example

